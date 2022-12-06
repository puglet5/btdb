# frozen_string_literal: true

class MeasurementsController < ApplicationController
  before_action :set_sample
  before_action :set_measurement, only: %i[edit update destroy]

  def new
    @measurement = @sample.measurements.build
    @measurement.spectra.build

    authorize @measurement
  end

  def edit
    authorize @measurement
  end

  def create
    @measurement = @sample.measurements.build measurement_params
    current_user.measurements << @measurement

    authorize @measurement

    if @measurement.save
      flash[:success] = 'Measurement was successfully created.'
      redirect_to @sample
    else
      @measurement.spectra.build
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @measurement

    if @measurement.update(measurement_params)
      redirect_to [@sample], notice: 'Measurement was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @measurement

    @measurement.destroy

    flash[:success] = 'Measurement was successfully deleted'
    redirect_to [@sample], status: :see_other
  end

  private

  def set_measurement
    @measurement = @sample.measurements.find(params[:id])
  end

  def set_sample
    @sample = Sample.find(params[:sample_id])
  end

  def measurement_params
    params.require(:measurement).permit(
      :title,
      :date,
      :category,
      :equipment,
      :description,
      spectra_attributes: %i[id file],
      spectra_ids: [],
      equipment_settings: []
    )
  end
end
