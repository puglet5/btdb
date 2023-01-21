# frozen_string_literal: true

module Api
  module V1
    class MeasurementsController < ApiController
      def index
        @measurements = Measurement.all
        render json: @measurements
      end

      def show
        @measurement = Measurement.find_by(id: params[:id]) or not_found
        render json: @measurement
      end

      def create
        @measurement = current_user.measurements.build(measurement_params)

        if @measurement.save!
          render json: @measurement, status: :ok
        else
          render json: { errors: @measurement.errors }, status: :unprocessable_entity
        end
      end

      def update
        @measurement = Measurement.find_by(id: params[:id]) or not_found

        if @measurement.update(measurement_params)
          render json: @measurement, status: :ok
        else
          render json: { errors: @measurement.errors }, status: :unprocessable_entity
        end
      end

      private

      def measurement_params
        params.require(:measurement).permit(
          :sample_id, :equipment, :category, :date, :title
        )
      end
    end
  end
end
