# frozen_string_literal: true

RSpec.describe '/measurements', type: :request do
  let(:user) { create(:user) }

  let(:sample) { create(:sample) }

  let(:measurement) { create(:measurement) }

  let(:valid_attributes) do
    {
      title: 'test title',
      user_id: user.id,
      sample_id: sample.id,
      date: DateTime.current.to_date
    }
  end

  let(:invalid_attributes) do
    {
      title: nil,
      user_id: user.id,
      sample_id: sample.id
    }
  end

  before :each do
    login_as user
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_sample_measurement_url(sample)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      measurement = Measurement.create! valid_attributes
      get edit_sample_measurement_url(sample_id: sample.id, id: measurement.id)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    fcontext 'with valid parameters' do
      it 'creates a new Measurement' do
        expect do
          post sample_measurements_url(sample_id: sample.id), params: { measurement: valid_attributes }
        end.to change(Measurement, :count).by(1)
      end

      it 'redirects to the created measurement' do
        post sample_measurements_url(sample_id: sample.id), params: { measurement: valid_attributes }
        expect(response).to redirect_to(sample)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Measurement' do
        expect do
          post sample_measurements_url(sample_id: sample.id), params: { measurement: invalid_attributes }
        end.to change(Measurement, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post sample_measurements_url(sample_id: sample.id), params: { measurement: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { 'title' => 'new title' }
      end

      it 'updates the requested measurement' do
        measurement = Measurement.create! valid_attributes
        patch sample_measurement_url(sample, measurement), params: { measurement: new_attributes }
        measurement.reload
        expect(measurement.title).to eq(new_attributes['title'])
      end

      it 'redirects to the measurement' do
        measurement = Measurement.create! valid_attributes
        patch sample_measurement_url(sample, measurement), params: { measurement: new_attributes }
        measurement.reload
        expect(response).to redirect_to(sample)
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        measurement = Measurement.create! valid_attributes
        patch sample_measurement_url(id: measurement.id, sample_id: sample.id), params: { measurement: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested measurement' do
      measurement = Measurement.create! valid_attributes
      expect do
        delete sample_measurement_url(sample, measurement)
      end.to change(Measurement, :count).by(-1)
    end

    it 'redirects to the measurements list' do
      measurement = Measurement.create! valid_attributes
      delete sample_measurement_url(sample, measurement)
      expect(response).to redirect_to(sample)
    end
  end
end
