# frozen_string_literal: true

class ExperimentsController < ApplicationController
  before_action :set_experiment, only: %i[show edit update destroy]

  # GET /experiments or /experiments.json
  def index
    @experiments = Experiment.all
  end

  # GET /experiments/1 or /experiments/1.json
  def show; end

  # GET /experiments/new
  def new
    @experiment = Experiment.new
  end

  # GET /experiments/1/edit
  def edit; end

  # POST /experiments or /experiments.json
  def create
    @experiment = Experiment.new(experiment_params)

    respond_to do |format|
      if @experiment.save
        format.html { redirect_to experiment_url(@experiment), notice: 'Experiment was successfully created.' }
        format.json { render :show, status: :created, location: @experiment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiments/1 or /experiments/1.json
  def update
    respond_to do |format|
      if @experiment.update(experiment_params)
        format.html { redirect_to experiment_url(@experiment), notice: 'Experiment was successfully updated.' }
        format.json { render :show, status: :ok, location: @experiment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiments/1 or /experiments/1.json
  def destroy
    @experiment.destroy

    respond_to do |format|
      format.html { redirect_to experiments_url, notice: 'Experiment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_experiment
    @experiment = Experiment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def experiment_params
    params.require(:experiment).permit(:title, :author, :staff, :type, :status)
  end
end
