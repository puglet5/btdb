# frozen_string_literal: true

class AddUserIdToSamples < ActiveRecord::Migration[7.0]
  def change
    add_column :samples, :user_id, :integer
  end
end
