# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  id         :bigint           not null, primary key
#  title      :string
#  sample_id  :bigint           not null, indexed
#  user_id    :bigint           not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  equipment  :string           default(""), not null
#  category   :integer          default("not_set"), not null
#  date       :date
#
# Indexes
#
#  index_measurements_on_sample_id  (sample_id)
#  index_measurements_on_user_id    (user_id)
#

RSpec.describe Measurement, type: :model do
  context 'associations' do
    it { should belong_to(:sample) }
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:date) }
  end
end
