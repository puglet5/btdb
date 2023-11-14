# frozen_string_literal: true

class CreateMeasurments < ActiveRecord::Migration[7.0]
  def change
    create_table :measurments do |t|
      t.string :title
      t.references :sample, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
