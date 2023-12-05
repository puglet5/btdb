# frozen_string_literal: true

class AddPlainTextAttributesToMeasurements < ActiveRecord::Migration[7.1]
  def change
    change_table :measurements, bulk: true do |t|
      t.text :plain_text_equipment, null: true
      t.text :plain_text_description, null: true
    end
  end
end
