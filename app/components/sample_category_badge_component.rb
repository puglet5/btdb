# frozen_string_literal: true

class SampleCategoryBadgeComponent < ViewComponent::Base
  attr_reader :category

  def initialize(category: '', cls: '')
    @category = category
    @cls = cls
  end

  CATEGORIES = {
    'phantom' => 'text-lime-800 bg-lime-100',
    'mixed' => 'text-sky-800 bg-sky-100',
    'processed_meat' => 'text-amber-800 bg-amber-100',
    'not_set' => 'text-gray-800 bg-gray-100'
  }.freeze

  def color(category)
    CATEGORIES[category]
  end
end
