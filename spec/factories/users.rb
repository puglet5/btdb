# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  created_at             :datetime         not null
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  id                     :bigint           not null, primary key
#  name                   :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    name { 'Test User' }
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
