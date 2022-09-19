# frozen_string_literal: true

class ExperimentBadgeComponent < ViewComponent::Base
  def initialize(status: '', cls: '')
    @status = status
    @cls = cls
  end

  def color
    case @status
    when 'finished'
      'text-lime-800 bg-lime-100'
    when 'ongoing'
      'text-sky-800 bg-sky-100'
    when 'cancelled'
      'text-amber-800 bg-amber-100'
    when 'not_set'
      'text-gray-800 bg-gray-100'
    end
  end
end
