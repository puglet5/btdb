# frozen_string_literal: true

class SpectraController < ApplicationController
  before_action :set_measurement
  after_action :verify_authorized

  def show_processing_indicator
    @spectrum = @measurement.spectra.find_by id: params[:id]
    authorize @spectrum

    render partial: 'samples/spectrum_processing_indicator', locals: { spectrum: @spectrum }
  end

  def show_request_processing_button
    @spectrum = @measurement.spectra.find_by id: params[:id]
    authorize @spectrum

    render partial: 'samples/spectrum_request_processing_button', locals: { spectrum: @spectrum, measurement: @measurement, sample: @measurement.sample }
  end

  def show_chart_area
    @spectrum = @measurement.spectra.find_by id: params[:id]
    authorize @spectrum

    render partial: 'samples/spectrum_chart_area', locals: { spectrum: @spectrum, measurement: @measurement, sample: @measurement.sample }
  end

  def new
    @spectrum = Spectrum.new

    authorize @spectrum

    breadcrumb 'Home', :root
    breadcrumb 'Samples', :samples, match: :exact
    breadcrumb @measurement.sample.title, @measurement.sample, match: :exact
    breadcrumb 'New Spectrum', [:new, @measurement.sample, :spectrum], match: :exclusive
  end

  def edit
    @spectrum = @measurement.spectra.find(params[:id])

    authorize @spectrum

    breadcrumb 'Home', :root
    breadcrumb 'Samples', :samples, match: :exact
    breadcrumb @measurement.sample.title, @measurement.sample, match: :exact
    breadcrumb "#{ApplicationHelper.humanize_category @spectrum.category}, #{ApplicationHelper.humanize_file_format @spectrum.format}", @measurement.sample, match: :exact
    breadcrumb 'Edit', [:edit, @measurement.sample, @spectrum], match: :exclusive
  end

  def create
    @spectrum = @measurement.spectra.build(spectrum_params)

    authorize @spectrum

    @spectrum.user = current_user

    if @spectrum.save
      redirect_to @measurement.sample
      flash[:success] = 'Spectrum added!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @spectrum = @measurement.spectra.find(params[:id])

    authorize @spectrum

    if @spectrum.update(spectrum_params)
      redirect_to @measurement.sample
      flash[:success] = 'Spectrum updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spectrum = @measurement.spectra.find(params[:id])

    authorize @spectrum

    @spectrum.destroy
    flash[:success] = 'Spectrum deleted!'
    redirect_to @measurement, status: :see_other
  end

  def request_processing
    @spectrum = @measurement.spectra.find(params[:id])

    authorize @spectrum

    return if @spectrum.processing_pending? || @spectrum.processing_ongoing?

    @spectrum.processing_pending!
    SendProcessingRequestJob.perform_later @spectrum
    respond_to do |format|
      format.html do
        render partial: 'samples/spectrum_request_processing_button', locals: { spectrum: @spectrum, measurement: @measurement, sample: @measurement.sample }
      end
    end
  end

  private

  def spectrum_params
    params.require(:spectrum).permit(
      :file,
      :category,
      :metadata,
      :sample_thickness,
      :is_reference
    )
  end

  def set_measurement
    @measurement = Measurement.find(params[:measurement_id])
  end
end
