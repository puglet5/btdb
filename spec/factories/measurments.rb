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
FactoryBot.define do
  factory :measurment do
    title { 'MyString' }
    sample { nil }
    association :user, factory: :user, strategy: :build
  end
end
