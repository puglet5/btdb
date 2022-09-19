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
#  user_id    :bigint
#  metadata   :jsonb            not null
#
FactoryBot.define do
  factory :experiment do
    title { 'MyString' }
    author { 'MyString' }
    staff { 'MyString' }
    type { 1 }
    status { 1 }
  end
end
