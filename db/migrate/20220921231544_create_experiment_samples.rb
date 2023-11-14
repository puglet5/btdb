# frozen_string_literal: true

class CreateExperimentSamples < ActiveRecord::Migration[7.0]
  def change
    create_table :experiment_samples do |t|
      t.references :experiment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
