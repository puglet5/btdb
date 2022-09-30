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

RSpec.describe ExperimentSample, type: :model do
  describe 'associations' do
    it { should belong_to(:experiment) }
    it { should belong_to(:sample) }
  end
end
