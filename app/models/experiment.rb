# frozen_string_literal: true

# == Schema Information
#
# Table name: experiments
#
#  author     :string           default(""), not null
#  category   :integer          default("not_set")
#  close_date :date
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  metadata   :jsonb            not null, indexed
#  open_date  :date
#  staff      :string           default(""), not null
#  status     :integer          default("not_set")
#  title      :string           default(""), not null
#  updated_at :datetime         not null
#  user_id    :bigint           indexed
#
# Indexes
#
#  index_experiments_on_metadata  (metadata) USING gin
#  index_experiments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_29fe176967  (user_id => users.id)
#
class Experiment < ApplicationRecord
  include ParseJson
  include ProcessImage
  include ArTransactionChanges

  acts_as_favoritable

  belongs_to :user

  has_many :experiment_samples, dependent: :destroy
  has_many :samples, through: :experiment_samples, dependent: :destroy

  validates :title, :author, presence: true

  enum status: { not_set: 0, ongoing: 1, cancelled: 2, finished: 3 }, _default: :not_set
  enum category: { not_set: 0, processed_meat: 1, phantom: 2, mixed: 3 }, _suffix: :category, _default: :not_set

  has_rich_text :description

  has_many_attached :images do |blob|
    blob.variant :thumbnail, resize: '400x300^', crop: '400x300+0+0', format: :jpg
  end

  has_many_attached :files

  after_commit :parse_json, on: %i[create update]
  after_commit -> { images.each { |image| process_image self, image&.id } }, on: %i[create update], unless: -> { transaction_changed_attributes.keys == ['updated_at'] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[author category close_date created_at metadata open_date staff status title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[experiment_samples favorited files_attachments images_attachments rich_text_description samples user]
  end
end
