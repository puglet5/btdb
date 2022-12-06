# frozen_string_literal: true

RSpec.describe MeasurementsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/samples/1/measurements/new').to route_to('measurements#new', sample_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/samples/1/measurements/1/edit').to route_to('measurements#edit', id: '1', sample_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/samples/1/measurements').to route_to('measurements#create', sample_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/samples/1/measurements/1').to route_to('measurements#update', id: '1', sample_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/samples/1/measurements/1').to route_to('measurements#update', id: '1', sample_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/samples/1/measurements/1').to route_to('measurements#destroy', id: '1', sample_id: '1')
    end
  end
end
