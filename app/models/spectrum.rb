# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  id             :bigint           not null, primary key
#  measurement_id :bigint           not null, indexed
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_spectra_on_measurement_id  (measurement_id)
#
class Spectrum < ApplicationRecord
  belongs_to :measurement, inverse_of: :spectra

  has_one_attached :file
end
