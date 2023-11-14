# frozen_string_literal: true

class IndexForeignKeysInExperimentSamples < ActiveRecord::Migration[7.0]
  def change
    add_index :experiment_samples, :sample_id
  end
end
