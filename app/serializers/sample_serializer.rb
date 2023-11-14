# frozen_string_literal: true

# == Schema Information
#
# Table name: samples
#
#  category    :integer          default("not_set"), not null
#  created_at  :datetime         not null
#  id          :bigint           not null, primary key
#  metadata    :jsonb            not null, indexed
#  survey_date :datetime
#  title       :string
#  updated_at  :datetime         not null
#  user_id     :integer          indexed
#
# Indexes
#
#  index_samples_on_metadata  (metadata) USING gin
#  index_samples_on_user_id   (user_id)
#
class SampleSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :name
  end

  attributes :id, :title, :metadata, :category, :survey_date
  has_many :spectra, key: :spectra_count do
    object.spectra.count
  end

  has_many :measurements, key: :measurements_count do
    object.measurements.count
  end

  has_many :files, key: :files_count do
    object.files.count
  end

  has_many :images, key: :images_count do
    object.images.count
  end

  belongs_to :user, serializer: UserSerializer
end
