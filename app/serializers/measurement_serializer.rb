# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  id         :bigint           not null, primary key
#  title      :string
#  sample_id  :bigint           not null, indexed
#  user_id    :bigint           not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  equipment  :string           default(""), not null
#  category   :integer          default("not_set"), not null
#  date       :date
#
# Indexes
#
#  index_measurements_on_sample_id  (sample_id)
#  index_measurements_on_user_id    (user_id)
#
class MeasurementSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :name
  end

  class SampleSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  attributes :id, :title, :category, :date, :equipment, :description

  has_many :spectra, key: :spectra_count do
    object.spectra.count
  end

  has_many :equipment_settings, key: :settings_attachments do
    object.equipment_settings.count
  end

  belongs_to :user, serializer: UserSerializer
  belongs_to :sample, serializer: SampleSerializer
end
