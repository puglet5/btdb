# frozen_string_literal: true

RSpec.fdescribe '/measurments', type: :request do
  let(:user) { create(:user) }

  let(:sample) { create(:sample) }

  let(:valid_attributes) do
    {
      'title' => 'test title',
      'sample_id' => sample.id,
      'user_id' => user.id
    }
  end

  let(:invalid_attributes) do
    {
      'title' => nil,
      'sample_id' => sample.id,
      'user_id' => user.id
    }
  end

  before :each do
    login_as user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Measurment.create! valid_attributes
      get sample_measurments_url(sample_id: sample.id)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      measurment = Measurment.create! valid_attributes
      get sample_measurment_url(sample_id: sample.id, id: measurment.id)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_sample_measurment_url(sample)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      measurment = Measurment.create! valid_attributes
      get edit_sample_measurment_url(sample_id: sample.id, id: measurment.id)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Measurment' do
        expect do
          post sample_measurments_url(sample_id: sample.id), params: { measurment: valid_attributes }
        end.to change(Measurment, :count).by(1)
      end

      it 'redirects to the created measurment' do
        post sample_measurments_url(sample_id: sample.id), params: { measurment: valid_attributes }
        expect(response).to redirect_to(sample_measurment_url(sample.id, Measurment.last.id))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Measurment' do
        expect do
          post sample_measurments_url(sample_id: sample.id), params: { measurment: invalid_attributes }
        end.to change(Measurment, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post sample_measurments_url(sample_id: sample.id), params: { measurment: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { 'title' => 'new title' }
      end

      it 'updates the requested measurment' do
        measurment = Measurment.create! valid_attributes
        patch sample_measurment_url(sample, measurment), params: { measurment: new_attributes }
        measurment.reload
        expect(measurment.title).to eq(new_attributes['title'])
      end

      it 'redirects to the measurment' do
        measurment = Measurment.create! valid_attributes
        patch sample_measurment_url(sample, measurment), params: { measurment: new_attributes }
        measurment.reload
        expect(response).to redirect_to(sample_measurment_url(measurment))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        measurment = Measurment.create! valid_attributes
        patch sample_measurment_url(id: measurment.id, sample_id: sample.id), params: { measurment: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested measurment' do
      measurment = Measurment.create! valid_attributes
      expect do
        delete sample_measurment_url(sample, measurment)
      end.to change(Measurment, :count).by(-1)
    end

    it 'redirects to the measurments list' do
      measurment = Measurment.create! valid_attributes
      delete sample_measurment_url(sample, measurment)
      expect(response).to redirect_to(sample_measurments_url)
    end
  end
end
