# frozen_string_literal: true

# == Schema Information
#
# Table name: samples
#
#  id          :bigint           not null, primary key
#  title       :string
#  category    :integer          default("not_set"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  metadata    :jsonb            not null
#  survey_date :datetime
#
class Sample < ApplicationRecord
  include ParseJson
  include ProcessImage

  has_many :experiment_samples, dependent: :destroy
  has_many :measurements, dependent: :destroy
  has_many :spectra, through: :measurements, dependent: :destroy
  # https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#module-ActiveRecord::Associations::ClassMethods-label-Delete+or+destroy-3F
  has_many :experiments, through: :experiment_samples, dependent: :destroy

  belongs_to :user

  has_rich_text :description

  has_one_attached :thumbnail do |blob|
    blob.variant :thumbnail, resize: '400x300^', crop: '400x300+0+0', format: :jpg
    blob.variant :banner, resize: '1600x900^', crop: '1600x900+0+0', format: :jpg
  end

  has_many_attached :images do |blob|
    blob.variant :thumbnail, resize: '400x300^', crop: '400x300+0+0', format: :jpg
  end

  has_many_attached :files

  enum category: { not_set: 0, processed_meat: 1, phantom: 2, mixed: 3 }, _suffix: :category, _default: :not_set

  validates :title, presence: true

  after_commit :parse_json, on: %i[create update]
  after_commit -> { process_image self, thumbnail&.id }, on: %i[create update]
  after_commit -> { images.each { |image| process_image self, image&.id } }, on: %i[create update]
end
