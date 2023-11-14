# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  category   :integer          default("not_set"), not null
#  created_at :datetime         not null
#  date       :date
#  equipment  :string           default(""), not null
#  id         :bigint           not null, primary key
#  sample_id  :bigint           not null, indexed
#  title      :string
#  updated_at :datetime         not null
#  user_id    :bigint           not null, indexed
#
# Indexes
#
#  index_measurements_on_sample_id  (sample_id)
#  index_measurements_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_6baaea43ce  (sample_id => samples.id)
#  fk_rails_b199c8b9fc  (user_id => users.id)
#
FactoryBot.define do
  factory :measurement do
    title { 'Test Measurement' }
    association :sample, factory: :sample, strategy: :build
    association :user, factory: :user, strategy: :build
  end
end
