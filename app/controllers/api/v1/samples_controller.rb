# frozen_string_literal: true

module Api
  module V1
    class SamplesController < ApiController
      def index
        @samples = Sample.all
        render json: @samples
      end

      def show
        @sample = Sample.find_by(id: params[:id]) or not_found
        render json: @sample
      end

      def create
        @sample = current_user.samples.build(sample_params)

        if @sample.save!
          render json: @sample, status: :ok
        else
          render json: { errors: @sample.errors }, status: :unprocessable_entity
        end
      end

      private

      def sample_params
        params.fetch(:sample, {}).permit(
          :title,
          :category,
          :description,
          :thumbnail,
          :survey_date,
          :metadata,
          experiment_ids: [],
          images: [],
          files: []
        )
      end
    end
  end
end
