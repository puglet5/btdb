# frozen_string_literal: true

class RenameMeasurmentsTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :measurments, :measurements
  end
end
