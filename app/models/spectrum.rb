# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  created_at     :datetime         not null
#  id             :bigint           not null, primary key
#  measurement_id :bigint           not null, indexed
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_spectra_on_measurement_id  (measurement_id)
#
# Foreign Keys
#
#  fk_rails_7788863ffe  (measurement_id => measurements.id)
#
class Spectrum < ApplicationRecord
  scope :by_measurement, ->(id) { where(measurement_id: id) }
  scope :by_sample, ->(id) { joins(:measurement).where(measurements: { sample_id: id }) }

  # dates are passed in ISO 8601 format, i.e. YYYY-MM-DD.
  scope :by_created_at_period, ->(start_date, end_date) { where('created_at BETWEEN ? and ?', start_date, end_date) }

  belongs_to :measurement, inverse_of: :spectra

  has_one_attached :file
end
