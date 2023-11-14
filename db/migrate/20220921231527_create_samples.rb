# frozen_string_literal: true

class CreateSamples < ActiveRecord::Migration[7.0]
  def change
    create_table :samples do |t|
      t.string :title
      t.integer :category

      t.timestamps
    end
  end
end
