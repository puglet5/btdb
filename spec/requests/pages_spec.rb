# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end

  fdescribe 'GET /home' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end
end
