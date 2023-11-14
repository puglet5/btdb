# frozen_string_literal: true

class ValidateSampleCategoryNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:samples, :category, false)
  end
end
