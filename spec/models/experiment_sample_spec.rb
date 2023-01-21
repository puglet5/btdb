# frozen_string_literal: true

# == Schema Information
#
# Table name: experiment_samples
#
#  id            :bigint           not null, primary key
#  experiment_id :bigint           not null, indexed
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  sample_id     :integer          indexed
#
# Indexes
#
#  index_experiment_samples_on_experiment_id  (experiment_id)
#  index_experiment_samples_on_sample_id      (sample_id)
#

RSpec.describe ExperimentSample, type: :model do
  describe 'associations' do
    it { should belong_to(:experiment) }
    it { should belong_to(:sample) }
  end
end
