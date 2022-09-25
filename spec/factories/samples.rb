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
FactoryBot.define do
  factory :sample do
    title { 'MyString' }
    category { 1 }
    association :user, factory: :user, strategy: :build
  end
end
