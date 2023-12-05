# frozen_string_literal: true

# == Schema Information
#
# Table name: measurements
#
#  category               :integer          default("not_set"), not null
#  created_at             :datetime         not null
#  date                   :date
#  equipment              :string           default(""), not null
#  id                     :bigint           not null, primary key
#  plain_text_description :text
#  plain_text_equipment   :text
#  sample_id              :bigint           not null, indexed
#  title                  :string
#  updated_at             :datetime         not null
#  user_id                :bigint           not null, indexed
#
# Indexes
#
#  index_measurements_on_sample_id  (sample_id)
#  index_measurements_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_6baaea43ce  (sample_id => samples.id)
#  fk_rails_b199c8b9fc  (user_id => users.id)
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
