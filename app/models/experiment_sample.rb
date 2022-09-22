# frozen_string_literal: true

# == Schema Information
#
# Table name: experiment_samples
#
#  id            :bigint           not null, primary key
#  experiment_id :bigint           not null
#  sample_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ExperimentSample < ApplicationRecord
  belongs_to :experiment
  belongs_to :sample
end
