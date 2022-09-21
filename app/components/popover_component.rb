# frozen_string_literal: true

class PopoverComponent < ViewComponent::Base
  def initialize(cls: '', text: '')
    @cls = cls
    @text = text
  end
end
