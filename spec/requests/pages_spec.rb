# frozen_string_literal: true

RSpec.describe 'Pages', type: :request do
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end

  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end
end
