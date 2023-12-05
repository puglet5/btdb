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

  AXES_SPEC = {
    not_set: { columnAxisType: 'xy', spectroscopyMethod: 'not_set', axesLabels: ['', ''], xAxisReverse: false, peakLabelPrecision: 0, yAxisMin: 0 },
    ftir: { columnAxisType: 'xy', spectroscopyMethod: 'ftir', axesLabels: ['Wavenumber, 1/cm', 'Intensity, a.u.'], xAxisReverse: true, peakLabelPrecision: 0, yAxisMin: 0 },
    raman: { columnAxisType: 'xy', spectroscopyMethod: 'raman', axesLabels: ['Raman shift, 1/cm', 'Intensity, a.u.'], xAxisReverse: false, peakLabelPrecision: 0, yAxisMin: 0 },
    thz: { columnAxisType: 'xyyxy', spectroscopyMethod: 'thz', axesLabels: ['Frequency, THz', 'Intensity, a.u.'], xAxisReverse: false, peakLabelPrecision: 2, yAxisMin: nil },
    other: { columnAxisType: 'xy', spectroscopyMethod: 'other', axesLabels: ['', ''], reverse: false, peakLabelPrecision: 0, yAxisMin: nil }
  }.freeze

  HEADER_MATCH_TABLE = {
    raman_txt: {
      regex_lines: [Regexp.new("^[+-]?([0-9]*[.])?[0-9]+[\t][+-]?([0-9]*[.])?[0-9]+$")]
    },
    ftir_dpt: {
      regex_lines: [Regexp.new('^[+-]?([0-9]*[.])?[0-9]+[,][+-]?([0-9]*[.])?[0-9]+$')]
    },
    thz_txt: {
      regex_lines: [
        Regexp.new("^[+-]?([0-9]*[,])?[0-9]+\t[+-]?([0-9]*[,])?[0-9]+$"),
        Regexp.new("^[+-]?([0-9]*[,])?[0-9]+\t[+-]?([0-9]*[,])?[0-9]+$"),
        Regexp.new("^[+-]?([0-9]*[,])?[0-9]+\t[+-]?([0-9]*[,])?[0-9]+$")
      ]
    }
  }.freeze

  scope :by_measurement, ->(id) { where(measurement_id: id) }
  scope :by_sample, ->(id) { joins(:measurement).where(measurements: { sample_id: id }) }
  scope :by_type, ->(category) { where(category: category) }
  scope :by_status, ->(status) { where(status: status) }

  # dates are passed in ISO 8601 format, i.e. YYYY-MM-DD.
  scope :by_created_at_period, ->(start_date, end_date) { where('created_at BETWEEN ? and ?', start_date, end_date) }

  belongs_to :measurement, inverse_of: :spectra
  belongs_to :user, inverse_of: :spectra

  has_one_attached :file
  has_one_attached :processed_file
  has_one_attached :settings

  before_save -> { self.filename ||= file.filename }
  after_create -> { infer_format }
  after_commit :parse_metadata, on: %i[create update]
  after_commit :parse_processing_message, on: %i[update]

  after_commit -> { infer_type }, on: %i[create], if: ->(s) { s.file.attached? && s.file.persisted? }

  enum format: { not_set: 0, csv: 1, txt: 2, other: 99 }, _default: :not_set, _suffix: :format

  enum status: { none: 0, successful: 1, pending: 2, ongoing: 3, error: 4, other: 5 }, _prefix: :processing, _default: :none
  enum category: { not_set: 0, ftir: 3, raman: 5, thz: 6, other: 99 }, _default: :not_set, _suffix: :type

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

  def infer_type
    return unless file.attached? || !not_set_type?

    file_path = ActiveStorage::Blob.service.path_for(file.key)

    file_encoding = CharDet.detect(File.open(file_path, &:readline))['encoding']

    File.open(file_path, 'r', encoding: file_encoding) do |f|
      HEADER_MATCH_TABLE.stringify_keys.each do |k, v|
        res = v[:regex_lines].map { |r| r.match?(f.gets.strip) }
        if res.all?
          # rubocop:disable Rails/SkipsModelValidations
          update_column(:category, k.split('_')[0])
          # rubocop:enable Rails/SkipsModelValidations
          break
        end
        f.rewind
      end
    end
  end

  def request_processing(initiator)
    SendProcessingRequestJob.perform_later initiator
  end
end
