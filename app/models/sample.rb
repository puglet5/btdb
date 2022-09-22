# frozen_string_literal: true

# == Schema Information
#
# Table name: samples
#
#  id         :bigint           not null, primary key
#  title      :string
#  category   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Sample < ApplicationRecord
  has_many :experiment_samples, dependent: :destroy
  has_many :experiments, through: :experiment_samples
  belongs_to :user

  validates :title, presence: true

  has_rich_text :description
  has_many_attached :images
  has_many_attached :files
end
