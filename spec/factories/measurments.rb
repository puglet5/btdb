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
FactoryBot.define do
  factory :measurment do
    title { 'Test Measurment' }
    association :sample, factory: :sample, strategy: :build
    association :user, factory: :user, strategy: :build
  end
end
