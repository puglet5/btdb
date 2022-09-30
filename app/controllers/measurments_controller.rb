# frozen_string_literal: true

class MeasurmentsController < ApplicationController
  before_action :set_sample
  before_action :set_measurment, only: %i[edit update destroy]

  def new
    @measurment = @sample.measurments.build

    authorize @measurment
  end

  def edit
    authorize @measurment
  end

  def create
    @measurment = @sample.measurments.build measurment_params
    current_user.measurments << @measurment

    authorize @measurment

    if @measurment.save
      redirect_to [@sample], notice: 'Measurment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @measurment

    if @measurment.update(measurment_params)
      redirect_to [@sample], notice: 'Measurment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @measurment

    @measurment.destroy

    flash[:success] = 'Measurment was successfully deleted'
    redirect_to [@sample], status: :see_other
  end

  private

  def set_measurment
    @measurment = @sample.measurments.find(params[:id])
  end

  def set_sample
    @sample = Sample.find(params[:sample_id])
  end

  def measurment_params
    params.require(:measurment).permit(
      :title,
      :date,
      :category,
      :equipment,
      :description,
      spectra_ids: [],
      equipment_settings: []
    )
  end
end
