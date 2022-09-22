# frozen_string_literal: true

# == Schema Information
#
# Table name: samples
#
#  id         :bigint           not null, primary key
#  title      :string
#  category   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  metadata   :jsonb            not null
#
require 'rails_helper'

RSpec.describe Sample, type: :model do
  it { should have_many(:experiments) }
  it { should have_many(:experiment_samples) }
end
