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
require 'rails_helper'

RSpec.describe ExperimentSample, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
