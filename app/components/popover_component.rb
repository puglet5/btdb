# frozen_string_literal: true

class PopoverComponent < ViewComponent::Base
  def initialize(user: nil, text: '', cls: '')
    @cls = cls
    @text = text
    @user = user
  end

  def render?
    @user&.settings(:ui)&.tooltips
  end
end
