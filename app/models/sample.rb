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
  include ProcessImages

  has_many :experiment_samples, dependent: :destroy
  has_many :measurments, dependent: :destroy
  has_many :spectra_attachments, through: :measurments

  # https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#module-ActiveRecord::Associations::ClassMethods-label-Delete+or+destroy-3F
  has_many :experiments, through: :experiment_samples, dependent: :destroy

  belongs_to :user

  has_rich_text :description

  has_one_attached :thumbnail do |blob|
    blob.variant :thumbnail, resize: '400x300^', crop: '400x300+0+0', format: :jpg
  end

  has_many_attached :images do |blob|
    blob.variant :thumbnail, resize: '400x300^', crop: '400x300+0+0', format: :jpg
  end

  has_many_attached :files

  enum category: { not_set: 0, processed_meat: 1, phantom: 2, mixed: 3 }, _suffix: :category

  validates :title, presence: true

  # after_save :invalidate_cached_experiments
  after_commit :parse_json, on: %i[create update]
  after_commit :process_images, on: %i[create update]

  # private

  # def invalidate_cached_experiments
  #   experiments.touch_all
  # end
end
