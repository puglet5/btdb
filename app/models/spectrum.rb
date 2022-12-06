# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  id            :bigint           not null, primary key
#  measurement_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Spectrum < ApplicationRecord
  belongs_to :measurement, inverse_of: :spectra

  has_one_attached :file
end
