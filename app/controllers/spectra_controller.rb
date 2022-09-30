# frozen_string_literal: true

class SpectraController < ApplicationController
  private

  def spectrum_params
    params.require(:spectrum).permit(
      files: []
    )
  end
end
