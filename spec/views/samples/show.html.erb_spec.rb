# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'samples/show', type: :view do
  before(:each) do
    @sample = assign(:sample, Sample.create!(
                                title: 'Title',
                                category: 2
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/2/)
  end
end
