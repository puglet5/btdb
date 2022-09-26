# frozen_string_literal: true

class ProcessImagesJob < ApplicationJob
  queue_as :default

  def perform(obj)
    obj.images.each do |image|
      next unless image&.representable?

      thumbnail = image.variant(:thumbnail)
      thumbnail.processed
    end
  end
end
