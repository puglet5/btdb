# frozen_string_literal: true

class AddAdditionalFieldsToMeasurments < ActiveRecord::Migration[7.0]
  def change
    change_table :measurments, bulk: true do |_t|
      t.string :equipment, null: false, default: ''
      t.integer :category, null: false, default: 0
    end
  end
end
