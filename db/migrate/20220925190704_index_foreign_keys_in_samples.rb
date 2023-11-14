# frozen_string_literal: true

class IndexForeignKeysInSamples < ActiveRecord::Migration[7.0]
  def change
    add_index :samples, :user_id
  end
end
