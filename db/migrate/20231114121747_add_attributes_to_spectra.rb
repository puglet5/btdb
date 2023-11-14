# frozen_string_literal: true

class AddAttributesToSpectra < ActiveRecord::Migration[7.1]
  def change
    change_table :spectra, bulk: true do |t|
      t.float :sample_thickness, null: true
      t.boolean :is_reference, default: false, null: false
      t.integer :status, default: 0, null: false
      t.integer :format, default: 0, null: false
      t.text :processing_message, null: true
      t.string :filename, null: true
      t.jsonb :metadata, null: false, default: '{}'
    end
    add_index :spectra, :metadata, using: :gin
  end
end
