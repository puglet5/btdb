# frozen_string_literal: true

class AddSurveyDateToSamples < ActiveRecord::Migration[7.0]
  def change
    add_column :samples, :survey_date, :datetime
  end
end
