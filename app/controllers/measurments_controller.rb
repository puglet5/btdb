# frozen_string_literal: true

class MeasurmentsController < ApplicationController
  before_action :set_sample
  before_action :set_measurment, only: %i[show edit update destroy]

  def index
    @measurments = Measurment.all
  end

  def show; end

  def new
    @measurment = @sample.measurments.build
    current_user.measurments << @measurment
  end

  def edit; end

  def create
    @measurment = @sample.measurments.build measurment_params
    current_user.measurments << @measurment

    if @measurment.save
      redirect_to sample_measurment_path(id: @measurment.id), notice: 'Measurment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @measurment.update(measurment_params)
      redirect_to sample_measurment_path(id: @measurment.id), notice: 'Measurment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @measurment.destroy
    flash[:success] = 'Measurment was successfully deleted'
    redirect_to sample_measurments_path, status: :see_other
  end

  private

  def set_measurment
    @measurment = Measurment.find(params[:id])
  end

  def set_sample
    @sample = Sample.find(params[:sample_id])
  end

  def measurment_params
    params.require(:measurment).permit(:title)
  end
end
