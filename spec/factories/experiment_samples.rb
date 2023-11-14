# frozen_string_literal: true

# == Schema Information
#
# Table name: experiment_samples
#
#  created_at    :datetime         not null
#  experiment_id :bigint           not null, indexed
#  id            :bigint           not null, primary key
#  sample_id     :integer          indexed
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_experiment_samples_on_experiment_id  (experiment_id)
#  index_experiment_samples_on_sample_id      (sample_id)
#
# Foreign Keys
#
#  fk_rails_a2e2e20f7b  (experiment_id => experiments.id)
#
FactoryBot.define do
  factory :experiment_sample do
    experiment { nil }
  end
end
