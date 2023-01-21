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
class Measurement < ApplicationRecord
  belongs_to :sample, touch: true
  belongs_to :user
  has_many :spectra, inverse_of: :measurement, dependent: :destroy
  has_many :file_attachments, through: :spectra, dependent: :destroy
  accepts_nested_attributes_for :spectra, reject_if: proc { |attributes| attributes['file'].blank? }

  has_many_attached :equipment_settings

  has_rich_text :description

  enum category: { not_set: 0, spectrum: 1 }, _suffix: :category, _default: :not_set

  validates :title, presence: true
  validates :date, presence: true
end
