# frozen_string_literal: true

class AddDateToMeasurments < ActiveRecord::Migration[7.0]
  def change
    add_column :measurments, :date, :date
  end
end
