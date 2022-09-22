# frozen_string_literal: true

class ExperimentsController < ApplicationController
  before_action :set_experiment, only: %i[edit update destroy]

  def index
    @experiments = Experiment
                   .all
                   .includes([:user, :rich_text_description, :samples, :experiment_samples, { images_attachments: :blob }, { files_attachments: :blob }])
                   .order('created_at desc')
  end

  def show
    @experiment = Experiment
                  .includes(:samples, :experiment_samples, [{ images_attachments: :blob }, { files_attachments: :blob }])
                  .find(params[:id])
  end

  def new
    @experiment = current_user.experiments.build
  end

  def edit; end

  def create
    @experiment = current_user.experiments.build experiment_params

    if @experiment.save
      redirect_to experiment_url(@experiment)
      flash[:success] = 'Experiment was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @experiment.update experiment_params
      redirect_to experiment_url(@experiment)
      flash[:success] = 'Experiment was successfully updated'
    else
      render :edit, status: :unprocessable_entity
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
    params.require(:experiment).permit(
      :title,
      :author,
      :staff,
      :category,
      :status,
      :description,
      :open_date,
      :close_date,
      :metadata,
      images: [],
      files: []
    )
  end
end
