# frozen_string_literal: true

module ApplicationHelper
  def original_or_variant(image, variant)
    if variant.key
      variant.processed.url if image.service.exist?(variant.key)
    else
      image.url
    end
  end
end
