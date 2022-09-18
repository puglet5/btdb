# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExperimentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/experiments').to route_to('experiments#index')
    end

    it 'routes to #new' do
      expect(get: '/experiments/new').to route_to('experiments#new')
    end

    it 'routes to #show' do
      expect(get: '/experiments/1').to route_to('experiments#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/experiments/1/edit').to route_to('experiments#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/experiments').to route_to('experiments#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/experiments/1').to route_to('experiments#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/experiments/1').to route_to('experiments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/experiments/1').to route_to('experiments#destroy', id: '1')
    end
  end
end
