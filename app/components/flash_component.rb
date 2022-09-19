# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  def initialize(type: '', msg: '', cls: '')
    @cls = cls
    @type = type
    @msg = msg
  end

  def color
    case @type
    when 'error'
      'text-red-700 border-red-600/50 bg-red-50'
    when 'alert'
      'text-amber-700 border-amber-600/50 bg-amber-50'
    when 'success'
      'text-lime-700 border-lime-600/50 bg-lime-50'
    when 'notice'
      'text-sky-700 border-sky-600/50 bg-sky-50'
    end
  end
end
