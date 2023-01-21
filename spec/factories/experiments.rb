# frozen_string_literal: true

# == Schema Information
#
# Table name: experiments
#
#  id         :bigint           not null, primary key
#  title      :string           default(""), not null
#  author     :string           default(""), not null
#  staff      :string           default(""), not null
#  category   :integer          default("not_set")
#  status     :integer          default("not_set")
#  open_date  :date
#  close_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           indexed
#  metadata   :jsonb            not null, indexed
#
# Indexes
#
#  index_experiments_on_metadata  (metadata) USING gin
#  index_experiments_on_user_id   (user_id)
#
FactoryBot.define do
  factory :experiment do
    title { 'Test title' }
    author { 'John Doe' }
    staff { 'Jane Doe, John Doe' }
    metadata { '{"test_key": "test_value"}' }
    open_date { 1.day.ago }
    close_date { 1.day.ago }
    association :user, factory: :user, strategy: :build
  end
end
