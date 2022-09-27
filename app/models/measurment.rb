# frozen_string_literal: true

# == Schema Information
#
# Table name: measurments
#
#  id         :bigint           not null, primary key
#  title      :string
#  sample_id  :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  equipment  :string           default(""), not null
#  category   :integer          default("not_set"), not null
#  date       :date
#
class Measurment < ApplicationRecord
  belongs_to :sample
  belongs_to :user

  has_many_attached :spectra
  has_many_attached :equipment_settings

  enum category: { not_set: 0, spectrum: 1 }, _suffix: :category

  validates :title, presence: true
  validates :date, presence: true
end
