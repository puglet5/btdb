# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  created_at         :datetime         not null
#  filename           :string
#  format             :integer          default("not_set"), not null
#  id                 :bigint           not null, primary key
#  is_reference       :boolean          default(FALSE), not null
#  measurement_id     :bigint           not null, indexed
#  metadata           :jsonb            not null, indexed
#  processing_message :text
#  sample_thickness   :float
#  status             :integer          default("none"), not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null, indexed
#
# Indexes
#
#  index_spectra_on_measurement_id  (measurement_id)
#  index_spectra_on_metadata        (metadata) USING gin
#  index_spectra_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_7788863ffe  (measurement_id => measurements.id)
#
class Spectrum < ApplicationRecord
  include Authorship
  include ParseMetadata
  include CustomValidations

  scope :by_measurement, ->(id) { where(measurement_id: id) }
  scope :by_sample, ->(id) { joins(:measurement).where(measurements: { sample_id: id }) }

  # dates are passed in ISO 8601 format, i.e. YYYY-MM-DD.
  scope :by_created_at_period, ->(start_date, end_date) { where('created_at BETWEEN ? and ?', start_date, end_date) }

  belongs_to :measurement, inverse_of: :spectra
  belongs_to :user, inverse_of: :spectra

  has_one_attached :file
  has_one_attached :processed_file

  before_save -> { self.filename ||= file.filename }
  after_commit :parse_metadata, on: %i[create update]
  after_commit :parse_processing_message, on: %i[update]

  enum format: { not_set: 0, csv: 1, txt: 2, other: 99 }, _default: :not_set, _suffix: :format

  enum status: { none: 0, successful: 1, pending: 2, ongoing: 3, error: 4, other: 5 }, _prefix: :processing, _default: :none

  private

  def parse_processing_message
    return unless processing_message

    parsed_message = processing_message.gsub!(/^"|"?$/, '')
    # rubocop:disable Rails/SkipsModelValidations
    update_column(:processing_message, parsed_message) if parsed_message
    # rubocop:enable Rails/SkipsModelValidations
  end

  def infer_format
    return unless file.attached?

    file_format = file.filename.to_s.split('.').last

    if Spectrum.formats.key? file_format
      update format: file_format
    else
      update format: 'other'
    end
  end
end
