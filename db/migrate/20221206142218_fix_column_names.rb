# frozen_string_literal: true

class FixColumnNames < ActiveRecord::Migration[7.0]
  def change
    change_table :spectra do |t|
      t.rename :measurment_id, :measurement_id
    end
  end
end
