# frozen_string_literal: true

class SamplesController < ApplicationController
  include PurgeAttachment

  before_action :set_sample, only: %i[show update destroy]
  after_action :verify_authorized

  breadcrumb 'Home', :root
  breadcrumb 'Samples', :samples, match: :exact

  def index
    authorize Sample

    @samples = Sample
               .includes([:user, { thumbnail_attachment: :blob }, :experiments, :experiment_samples, :rich_text_description])
               .order('created_at desc')

    @query = @samples.ransack(params[:query])
    result = @query.result(distinct: true).order('created_at DESC')
    @pagy, @samples = pagy result
  end

  def show
    authorize @sample

    @measurements = @sample.measurements.order('date DESC')

    breadcrumb @sample.title, @sample, match: :exclusive
  end

  def new
    @sample = current_user.samples.build sample_params

    authorize @sample

    breadcrumb 'New Sample', %i[new sample], match: :exclusive
  end

  def edit
    @sample = Sample.with_attached_images
                    .with_attached_files
                    .find(params[:id])

    authorize @sample

    breadcrumb @sample.title, @sample, match: :exclusive
    breadcrumb 'Edit', [:edit, @sample], match: :exclusive
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

  def favorite
    @sample = Sample.find params[:id]
    authorize @sample

    if current_user.favorited? @sample
      current_user.unfavorite @sample
    else
      current_user.favorite @sample
    end
    redirect_to request.referer
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
