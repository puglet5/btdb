# frozen_string_literal: true

class AddSampleIdToExperimentSamples < ActiveRecord::Migration[7.0]
  def change
    add_column :experiment_samples, :sample_id, :integer
  end
end
