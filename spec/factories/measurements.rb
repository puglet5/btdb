# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  id         :bigint           not null, primary key
#  title      :string
#  sample_id  :bigint           not null, indexed
#  user_id    :bigint           not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  equipment  :string           default(""), not null
#  category   :integer          default("not_set"), not null
#  date       :date
#
# Indexes
#
#  index_measurements_on_sample_id  (sample_id)
#  index_measurements_on_user_id    (user_id)
#
FactoryBot.define do
  factory :measurement do
    title { 'Test Measurement' }
    association :sample, factory: :sample, strategy: :build
    association :user, factory: :user, strategy: :build
  end
end
