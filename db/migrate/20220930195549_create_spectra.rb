# frozen_string_literal: true

class CreateSpectra < ActiveRecord::Migration[7.0]
  def change
    create_table :spectra do |t|
      t.references :measurment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
