# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           default(""), not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'ActiveStorage avatar attachment' do
    it 'persists' do
      user.avatar.attach(io: File.open(file_fixture('test.png')), filename: 'test.png', content_type: 'image/png')
      user.save!
      expect(user.errors.messages[:avatar]).to eq []
      expect(user.avatar.persisted?).to eq(true)
    end
  end

  describe 'Associations' do
    it { should have_many(:experiments) }
    it { should have_many(:samples) }

    it { should have_one_attached(:avatar) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end
