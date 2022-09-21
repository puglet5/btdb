# frozen_string_literal: true

module ExperimentsHelper
  private

  def attachment_count(obj)
    obj.files.count + obj.images.count
  end
end
