# frozen_string_literal: true

# == Schema Information
#
# Table name: experiments
#
#  author     :string           default(""), not null
#  category   :integer          default("not_set")
#  close_date :date
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  metadata   :jsonb            not null, indexed
#  open_date  :date
#  staff      :string           default(""), not null
#  status     :integer          default("not_set")
#  title      :string           default(""), not null
#  updated_at :datetime         not null
#  user_id    :bigint           indexed
#
# Indexes
#
#  index_experiments_on_metadata  (metadata) USING gin
#  index_experiments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_29fe176967  (user_id => users.id)
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
