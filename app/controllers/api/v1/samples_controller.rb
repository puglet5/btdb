# frozen_string_literal: true

module Api
  module V1
    class SamplesController < ApiController
      def index
        @samples = Sample.all
        render json: @samples
      end
    end
  end
end
