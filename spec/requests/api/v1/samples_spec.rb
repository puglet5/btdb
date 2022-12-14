# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::SamplesController do
  before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  describe 'GET #index' do
    context 'when unauthorized' do
      it 'fails with HTTP 401' do
        get '/api/v1/samples'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authorized' do
      let(:application) { FactoryBot.create(:application) }
      let(:user)        { FactoryBot.create(:user) }
      let(:sample) { FactoryBot.create(:sample, user: user) }
      let(:token) { FactoryBot.create(:access_token, application: application, resource_owner_id: user.id) }

      it 'succeeds' do
        sample.save!
        get '/api/v1/samples', params: {}, headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to be_successful
        expect(JSON.parse(response.body).first).to eq(JSON.parse(sample.to_json))
      end
    end
  end
end
