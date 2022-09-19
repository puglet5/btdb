# frozen_string_literal: true

class ExperimentsController < ApplicationController
  before_action :set_experiment, only: %i[show edit update destroy]

  def index
    @experiments = Experiment.all
  end

  def show; end

  def new
    @experiment = current_user.experiments.build
  end

  def edit; end

  def create
    @experiment = current_user.experiments.build(experiment_params)

    respond_to do |format|
      if @experiment.save
        format.html { redirect_to experiment_url(@experiment), notice: 'Experiment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @experiment.update(experiment_params)
        format.html { redirect_to experiment_url(@experiment), notice: 'Experiment was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @experiment.destroy
    flash[:success] = 'Experiment was successfully deleted'
    redirect_to experiments_url, status: :see_other
  end

  private

  def set_experiment
    @experiment = Experiment.find(params[:id])
  end

  def experiment_params
    params.require(:experiment).permit(:title, :author, :staff, :category, :status, :description, :open_date, :close_date, :metadata)
  end
end
