# frozen_string_literal: true

class SamplesController < ApplicationController
  before_action :set_sample, only: %i[show edit update destroy]

  def index
    @samples = Sample
               .all
               .includes([:user, { thumbnail_attachment: :blob }])
               .order('created_at desc')
  end

  def show; end

  def new
    @sample = current_user.samples.build
  end

  def edit; end

  def create
    @sample = current_user.samples.build sample_params

    if @sample.save
      redirect_to sample_url(@sample), notice: 'Sample was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @sample.update(sample_params)
      redirect_to sample_url(@sample), notice: 'Sample was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sample.destroy

    redirect_to samples_url, notice: 'Sample was successfully destroyed.'
  end

  private

  def set_sample
    @sample = Sample.find(params[:id])
  end

  def sample_params
    params.require(:sample).permit(:title, :category)
  end
end
