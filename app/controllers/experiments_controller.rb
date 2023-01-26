# frozen_string_literal: true

class ExperimentsController < ApplicationController
  include PurgeAttachment

  before_action :set_experiment, only: %i[update destroy]
  after_action :verify_authorized

  breadcrumb 'Home', :root
  breadcrumb 'Experiments', :experiments, match: :exact

  def index
    authorize Experiment

    @experiments = Experiment
                   .all
                   .includes([:user, :rich_text_description, :samples, :experiment_samples, { images_attachments: :blob }, { files_attachments: :blob }])
                   .order('created_at desc')

    @query = @experiments.ransack(params[:query])
    result = @query.result(distinct: true).order('created_at DESC')
    @pagy, @experiments = pagy result
  end

  def show
    @experiment = Experiment
                  .includes(:samples, :experiment_samples, [{ images_attachments: :blob }, { files_attachments: :blob }])
                  .find(params[:id])

    authorize @experiment

    breadcrumb @experiment.title, @experiment, match: :exclusive
  end

  def new
    @experiment = current_user.experiments.build
    authorize @experiment

    breadcrumb 'New Experiment', %i[new experiment], match: :exclusive
  end

  def edit
    @experiment = Experiment
                  .with_attached_images
                  .with_attached_files
                  .find(params[:id])

    authorize @experiment

    breadcrumb @experiment.title, @experiment, match: :exclusive
    breadcrumb 'Edit', [:edit, @experiment], match: :exclusive
  end

  def create
    @experiment = current_user.experiments.build experiment_params

    authorize @experiment

    if @experiment.save
      redirect_to experiment_url(@experiment)
      flash.now[:success] = 'Experiment was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def favorite
    @experiment = Experiment.find params[:id]
    authorize @experiment

    if current_user.favorited? @experiment
      current_user.unfavorite @experiment
    else
      current_user.favorite @experiment
    end
    redirect_to request.referer
  end

  def update
    authorize @experiment

    if @experiment.update experiment_params

      attachment_params[:purge_attachments]&.each do |id|
        purge_attachment id
      end

      redirect_to experiment_url(@experiment)
      flash.now[:success] = 'Experiment was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @experiment

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
      sample_ids: [],
      images: [],
      files: []
    )
  end

  def attachment_params
    params.require(:experiment).permit(
      purge_attachments: []
    )
  end
end
