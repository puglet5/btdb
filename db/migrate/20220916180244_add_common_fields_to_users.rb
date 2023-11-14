# frozen_string_literal: true

class AddCommonFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, default: '', null: false
  end
end
