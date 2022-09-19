# frozen_string_literal: true

class ExperimentBadgeComponent < ViewComponent::Base
  attr_reader :status

  def initialize(status: '', cls: '')
    @status = status
    @cls = cls
  end

  STATUSES = {
    'finished' => 'text-lime-800 bg-lime-100',
    'ongoing' => 'text-sky-800 bg-sky-100',
    'cancelled' => 'text-amber-800 bg-amber-100',
    'not_set' => 'text-gray-800 bg-gray-100'
  }.freeze

  def color(status)
    STATUSES[status]
  end
end
