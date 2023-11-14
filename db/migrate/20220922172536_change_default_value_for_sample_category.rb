# frozen_string_literal: true

class ChangeDefaultValueForSampleCategory < ActiveRecord::Migration[7.0]
  def change
    change_column_default :samples, :category, from: nil, to: 0
  end
end
