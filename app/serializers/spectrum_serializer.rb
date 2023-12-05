# frozen_string_literal: true

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
