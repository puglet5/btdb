# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           default(""), not null
#
FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    first_name { 'Test User' }
    password { '123456' }
    sequence(:email) { |n| "test#{n}@test.com" }

    factory :default_user do
      after(:create) { |user| user.add_role(:default) }
    end

    factory :admin_user do
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
