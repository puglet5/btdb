# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'experiments/show', type: :view do
  before(:each) do
    @experiment = assign(:experiment, Experiment.create!(
                                        title: 'Title',
                                        author: 'Author',
                                        staff: 'Staff',
                                        type: 2,
                                        status: 3
                                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Staff/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
