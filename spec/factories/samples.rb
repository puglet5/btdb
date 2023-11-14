# frozen_string_literal: true

# == Schema Information
#
# Table name: samples
#
#  category    :integer          default("not_set"), not null
#  created_at  :datetime         not null
#  id          :bigint           not null, primary key
#  metadata    :jsonb            not null, indexed
#  survey_date :datetime
#  title       :string
#  updated_at  :datetime         not null
#  user_id     :integer          indexed
#
# Indexes
#
#  index_samples_on_metadata  (metadata) USING gin
#  index_samples_on_user_id   (user_id)
#
FactoryBot.define do
  factory :sample do
    title { 'MyString' }
    category { 1 }
    association :user, factory: :user, strategy: :build
  end
end
