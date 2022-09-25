# frozen_string_literal: true

class SamplesController < ApplicationController
  include PurgeAttachment

  before_action :set_sample, only: %i[show edit update destroy]
  before_action :authorize_sample!
  after_action :verify_authorized

  def index
    @samples = Sample
               .all
               .includes([:user, { thumbnail_attachment: :blob }])
               .order('created_at desc')

    @query = @samples.ransack(params[:query])
    @samples = @query.result(distinct: true).order('created_at DESC')
  end

  def show; end

  def new
    @sample = current_user.samples.build sample_params
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
    @sample.destroy

    redirect_to samples_url, notice: 'Sample was successfully destroyed.'
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

  def authorize_sample!
    authorize(@sample || Sample)
  end
end
