# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end

  describe 'GET /index' do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
