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

  has_many :experiment_samples, dependent: :destroy
  has_many :experiments, through: :experiment_samples
  has_many :measurments, dependent: :destroy
  has_many :spectra_attachments, through: :measurments

  belongs_to :user

  has_rich_text :description
  has_one_attached :thumbnail
  has_many_attached :images
  has_many_attached :files

  enum category: { not_set: 0, processed_meat: 1, phantom: 2, mixed: 3 }, _suffix: :category

  validates :title, presence: true

  after_commit :parse_json, on: %i[create update]
  after_commit :process_images, on: %i[create update]

  private

  def process_images
    ProcessImagesJob.perform_later(self)
  end
end
