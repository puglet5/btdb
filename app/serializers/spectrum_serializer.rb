# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  category           :integer
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
class SpectrumSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  def file_url
    return nil unless object.file.attached?

    rails_blob_path(object&.file, only_path: true)
  end

  def processed_file_url
    return nil unless object.processed_file.attached?

    rails_blob_path(object&.processed_file, only_path: true)
  end

  def axes
    Spectrum::AXES_SPEC[object.category.to_sym]
  end

  def filename
    object&.file&.filename
  end

  def processed_filename
    object&.processed_file&.filename
  end

  class SampleSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  attributes :id, :format, :status, :category, :metadata, :sample_thickness, :is_reference
  attributes :file_url
  attributes :processed_file_url
  attributes :filename
  attributes :processed_filename
  attributes :axes

  belongs_to :measurement, serializer: MeasurementSerializer
end
