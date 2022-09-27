# frozen_string_literal: true

# == Schema Information
#
# Table name: experiments
#
#  id         :bigint           not null, primary key
#  title      :string           default(""), not null
#  author     :string           default(""), not null
#  staff      :string           default(""), not null
#  category   :integer          default("not_set")
#  status     :integer          default("not_set")
#  open_date  :date
#  close_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  metadata   :jsonb            not null
#
class Experiment < ApplicationRecord
  include ParseJson
  include ProcessImages

  belongs_to :user

  has_many :experiment_samples, dependent: :destroy
  has_many :samples, through: :experiment_samples, dependent: :destroy

  validates :title, :author, presence: true

  enum status: { not_set: 0, ongoing: 1, cancelled: 2, finished: 3 }
  enum category: { not_set: 0, processed_meat: 1, phantom: 2, mixed: 3 }, _suffix: :category

  has_rich_text :description

  has_many_attached :images do |blob|
    blob.variant :thumbnail, resize: '400x300^', crop: '400x300+0+0', format: :jpg
  end

  has_many_attached :files

  after_commit :parse_json, on: %i[create update]
  after_commit :process_images, on: %i[create update]
end
