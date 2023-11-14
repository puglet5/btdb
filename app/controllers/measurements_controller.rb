# frozen_string_literal: true

class MeasurementsController < ApplicationController
  before_action :set_sample
  before_action :set_measurement, only: %i[edit update destroy]

  breadcrumb 'Home', :root
  breadcrumb 'Samples', :samples, match: :exact

  def new
    @measurement = @sample.measurements.build
    @measurement.spectra.build

    authorize @measurement

    breadcrumb @sample.title, @sample, match: :exclusive
    breadcrumb 'New Measurement', [:new, @sample, :measurement], match: :exclusive
  end

  def edit
    authorize @measurement

    breadcrumb @sample.title, @sample, match: :exclusive
    breadcrumb "#{@measurement.date&.strftime('%d/%m/%Y')} #{@measurement.title}", @sample, match: :exclusive
    breadcrumb 'Edit', [:edit, @sample, @measurement], match: :exclusive
  end

  def create
    @measurement = @sample.measurements.build measurement_params
    @measurement.spectra.each { |s| s.user = current_user }

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

    unless measurement_params[:spectra_attributes].nil?
      @spectra = @measurement.spectra.build(measurement_params[:spectra_attributes])
      @spectra.each { |s| s.user = current_user }
    end

    if @measurement.update(measurement_params.except(:spectra_attributes))
      @spectra&.each(&:save!)

      redirect_to @sample
      flash[:success] = 'Measurement updated!'
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
      spectra_attributes: %i[id file user_id],
      spectra_ids: [],
      equipment_settings: []
    )
  end
end
