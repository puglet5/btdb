# frozen_string_literal: true

class SamplesController < ApplicationController
  include PurgeAttachment

  before_action :set_sample, only: %i[show update destroy]
  after_action :verify_authorized

  def index
    authorize Sample

    @samples = Sample
               .all
               .includes([:user, { thumbnail_attachment: :blob }, :experiments, :experiment_samples, :rich_text_description])
               .order('created_at desc')

    @query = @samples.ransack(params[:query])
    @samples = @query.result(distinct: true).order('created_at DESC')
  end

  def show
    authorize @sample
  end

  def new
    @sample = current_user.samples.build sample_params

    authorize @sample
  end

  def edit
    @sample = Sample.with_attached_images
                    .with_attached_files
                    .find(params[:id])

    authorize @sample
  end

  def create
    @sample = current_user.samples.build sample_params

    authorize @sample

    if @sample.save
      redirect_to sample_url(@sample), notice: 'Sample was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @sample

    if @sample.update sample_params

      attachment_params[:purge_attachments]&.each do |id|
        purge_attachment id
      end

      redirect_to sample_url(@sample), notice: 'Sample was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @sample

    @sample.destroy

    flash[:success] = 'Sample was successfully deleted'
    redirect_to samples_url, status: :see_other
  end

  private

  def set_sample
    @sample = Sample.find(params[:id])
  end

  def sample_params
    params.fetch(:sample, {}).permit(
      :title,
      :category,
      :description,
      :thumbnail,
      :survey_date,
      :metadata,
      experiment_ids: [],
      images: [],
      files: []
    )
  end

  def attachment_params
    params.require(:sample).permit(
      purge_attachments: []
    )
  end
end
