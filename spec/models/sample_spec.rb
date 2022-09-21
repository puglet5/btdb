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
#
require 'rails_helper'

RSpec.describe Sample, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
