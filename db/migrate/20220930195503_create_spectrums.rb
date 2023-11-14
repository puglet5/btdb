# frozen_string_literal: true

class CreateSpectrums < ActiveRecord::Migration[7.0]
  def change
    create_table :spectrums do |t|
      t.references :measurment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
