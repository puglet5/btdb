# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  id             :bigint           not null, primary key
#  measurement_id :bigint           not null, indexed
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_spectra_on_measurement_id  (measurement_id)
#
class SpectrumSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  def file_url
    return nil unless object.file.attached?

    rails_blob_path(object&.file, only_path: true)
  end

  def filename
    object&.file&.filename
  end

  class MeasurementSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  attributes :id
  attributes :file_url
  attributes :filename

  belongs_to :measurement, serializer: MeasurementSerializer
end
