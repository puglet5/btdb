# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
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
  factory :measurement do
    title { 'Test Measurement' }
    association :sample, factory: :sample, strategy: :build
    association :user, factory: :user, strategy: :build
  end
end
