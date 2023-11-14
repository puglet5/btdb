# frozen_string_literal: true

class CreateExperiments < ActiveRecord::Migration[7.0]
  def change
    create_table :experiments do |t|
      t.string :title, null: false, default: ''
      t.string :author, null: false, default: ''
      t.string :staff, null: false, default: ''
      t.integer :category, default: 0
      t.integer :status, default: 0
      t.date :open_date
      t.date :close_date

      t.timestamps
    end

    add_reference :experiments, :user, foreign_key: true
  end
end
