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
class Measurement < ApplicationRecord
  scope :by_category, ->(category) { where(category: category) }
  scope :by_sample, ->(id) { where(sample_id: id) }

  # dates are passed in ISO 8601 format, i.e. YYYY-MM-DD.
  scope :by_created_at_period, ->(start_date, end_date) { where('created_at BETWEEN ? and ?', start_date, end_date) }
  scope :by_date, ->(date) { where(date: date) }
  scope :by_date_period, ->(start_date, end_date) { where('date BETWEEN ? and ?', start_date, end_date) }

  belongs_to :sample, touch: true
  belongs_to :user
  has_many :spectra, inverse_of: :measurement, dependent: :destroy
  has_many :file_attachments, through: :spectra, dependent: :destroy
  accepts_nested_attributes_for :spectra, reject_if: proc { |attributes| attributes['file'].blank? }

  has_many_attached :equipment_settings

  has_rich_text :description
  has_rich_text :equipment

  before_save { self.plain_text_description = description&.body&.to_plain_text }
  before_save { self.plain_text_equipment = equipment&.body&.to_plain_text }

  enum category: { not_set: 0, spectrum: 1 }, _suffix: :category, _default: :not_set

  validates :title, presence: true
  validates :date, presence: true
end
