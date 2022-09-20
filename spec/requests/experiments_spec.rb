# frozen_string_literal: true

RSpec.describe '/experiments', type: :request do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    { 'title' => 'Test title',
      'author' => 'John Doe',
      'staff' => 'Jane Doe',
      'category' => 'not_set',
      'user_id' => user.id,
      'status' => 'not_set',
      'metadata' => '{"test_key": "test_value"}' }
  end

  let(:invalid_attributes) do
    { 'title' => nil,
      'author' => 'John Doe' }
  end

  before :each do
    login_as user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Experiment.create! valid_attributes
      get experiments_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      experiment = Experiment.create! valid_attributes
      get experiment_url(experiment)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_experiment_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      experiment = Experiment.create! valid_attributes
      get edit_experiment_url(experiment)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Experiment' do
        expect do
          post experiments_url, params: { experiment: valid_attributes }
        end.to change(Experiment, :count).by(1)
      end

      it 'redirects to the created experiment' do
        post experiments_url, params: { experiment: valid_attributes }
        expect(response).to redirect_to(experiment_url(Experiment.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Experiment' do
        expect do
          post experiments_url, params: { experiment: invalid_attributes }
        end.to change(Experiment, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post experiments_url, params: { experiment: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          'title' => 'New Test Title'
        }
      end

      it 'updates the requested experiment' do
        experiment = Experiment.create! valid_attributes
        patch experiment_url(experiment), params: { experiment: new_attributes }
        experiment.reload
        expect(experiment.title).to eq(new_attributes['title'])
      end

      it 'redirects to the experiment' do
        experiment = Experiment.create! valid_attributes
        patch experiment_url(experiment), params: { experiment: new_attributes }
        experiment.reload
        expect(response).to redirect_to(experiment_url(experiment))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        experiment = Experiment.create! valid_attributes
        patch experiment_url(experiment), params: { experiment: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested experiment' do
      experiment = Experiment.create! valid_attributes
      expect do
        delete experiment_url(experiment)
      end.to change(Experiment, :count).by(-1)
    end

    it 'redirects to the experiments list' do
      experiment = Experiment.create! valid_attributes
      delete experiment_url(experiment)
      expect(response).to redirect_to(experiments_url)
    end
  end
end
