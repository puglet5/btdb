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
#
class Measurment < ApplicationRecord
  belongs_to :sample
  belongs_to :user

  has_many_attached :spectra

  validates :title, presence: true
end
