# frozen_string_literal: true

module Api
  module V1
    class SpectraController < ApiController
      has_scope :by_measurement
      has_scope :by_sample
      has_scope :by_created_at_period

      def index
        @spectra = apply_scopes(Spectrum).all
        render json: @spectra
      end

      def show
        @spectrum = Spectrum.find_by(id: params[:id]) or not_found
        render json: @spectrum
      end

      def create
        @spectrum = Spectrum.new(spectrum_params)
        @spectrum.user = current_user

        if @spectrum.save!
          render json: @spectrum, status: :ok
        else
          render json: { errors: @spectrum.errors }, status: :unprocessable_entity
        end
      end

      def update
        @spectrum = Spectrum.find_by(id: params[:id]) or not_found

        if @spectrum.update(spectrum_params)
          render json: @spectrum, status: :ok
        else
          render json: { errors: @spectrum.errors }, status: :unprocessable_entity
        end
      end

      private

      def spectrum_params
        params.require(:spectrum).permit(
          :measurement_id, :status, :metadata, :processed_file, :processing_message
        )
      end
    end
  end
end
