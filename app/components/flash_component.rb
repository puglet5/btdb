# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  attr_accessor :type

  def initialize(type: '', msg: '', cls: '')
    @cls = cls
    @type = type
    @msg = msg
  end

  TYPES = {
    'error' => 'text-red-700 border-red-600/50 bg-red-50',
    'alert' => 'text-amber-700 border-amber-600/50 bg-amber-50',
    'success' => 'text-lime-700 border-lime-600/50 bg-lime-50',
    'notice' => 'text-sky-700 border-sky-600/50 bg-sky-50'
  }.freeze

  def color(type)
    TYPES[type]
  end
end
