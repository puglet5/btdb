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
#  metadata   :jsonb            not null
#
FactoryBot.define do
  factory :sample do
    title { 'MyString' }
    category { 1 }
  end
end
