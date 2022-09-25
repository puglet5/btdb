# frozen_string_literal: true

class ProcessImagesJob < ApplicationJob
  queue_as :default

  def perform(obj)
    obj.images.each do |image|
      next unless image&.representable?

      thumbnail = image.representation(resize: '400x300^', crop: '400x300+0+0')
      thumbnail.processed
    end
  end
end
