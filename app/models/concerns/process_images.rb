# frozen_string_literal: true

module ProcessImages
  extend ActiveSupport::Concern

  included do
    def process_images
      ProcessImagesJob.perform_later(self)
    end
  end
end
