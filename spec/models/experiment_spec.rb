# frozen_string_literal: true

# == Schema Information
#
# Table name: experiments
#
#  author     :string           default(""), not null
#  category   :integer          default("not_set")
#  close_date :date
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  metadata   :jsonb            not null, indexed
#  open_date  :date
#  staff      :string           default(""), not null
#  status     :integer          default("not_set")
#  title      :string           default(""), not null
#  updated_at :datetime         not null
#  user_id    :bigint           indexed
#
# Indexes
#
#  index_experiments_on_metadata  (metadata) USING gin
#  index_experiments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_29fe176967  (user_id => users.id)
#
RSpec.describe Experiment, type: :model do
  let(:user) { create(:user) }

  let(:valid_experiment) { build(:experiment, user: user) }

  before(:each) do
    valid_experiment.images.delete_all
    valid_experiment.files.delete_all
  end

  describe 'defaults' do
    it 'has a parsed metadata' do
      valid_experiment.save!
      expect(valid_experiment.metadata).to be_a(Hash).or eq('{}')
    end

    it 'has a default status of not set' do
      valid_experiment.save!
      expect(valid_experiment.status).to eq('not_set')
    end

    it 'has a default category of not set' do
      valid_experiment.save!
      expect(valid_experiment.category).to eq('not_set')
    end

    it 'has no attachments by default' do
      valid_experiment.save!
      expect(valid_experiment.images.any?).to eq(false)
      expect(valid_experiment.files.any?).to eq(false)
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:experiment_samples) }
    it { should have_many(:samples) }
    it { should have_many_attached(:images) }
    it { should have_many_attached(:files) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
  end
end
