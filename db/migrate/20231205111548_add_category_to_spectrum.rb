# frozen_string_literal: true

class AddCategoryToSpectrum < ActiveRecord::Migration[7.1]
  def change
    add_column :spectra, :category, :integer
  end
end
