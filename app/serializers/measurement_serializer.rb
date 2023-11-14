# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  category   :integer          default("not_set"), not null
#  created_at :datetime         not null
#  date       :date
#  equipment  :string           default(""), not null
#  id         :bigint           not null, primary key
#  sample_id  :bigint           not null, indexed
#  title      :string
#  updated_at :datetime         not null
#  user_id    :bigint           not null, indexed
#
# Indexes
#
#  index_measurements_on_sample_id  (sample_id)
#  index_measurements_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_6baaea43ce  (sample_id => samples.id)
#  fk_rails_b199c8b9fc  (user_id => users.id)
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
