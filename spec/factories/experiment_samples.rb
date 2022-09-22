# frozen_string_literal: true

# == Schema Information
#
# Table name: experiment_samples
#
#  id            :bigint           not null, primary key
#  experiment_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  sample_id     :integer
#
FactoryBot.define do
  factory :experiment_sample do
    experiment { nil }
  end
end
