# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  id            :bigint           not null, primary key
#  measurment_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Spectrum, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
