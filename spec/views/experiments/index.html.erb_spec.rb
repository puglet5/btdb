# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'experiments/index', type: :view do
  before(:each) do
    assign(:experiments, [
             Experiment.create!(
               title: 'Title',
               author: 'Author',
               staff: 'Staff',
               type: 2,
               status: 3
             ),
             Experiment.create!(
               title: 'Title',
               author: 'Author',
               staff: 'Staff',
               type: 2,
               status: 3
             )
           ])
  end

  it 'renders a list of experiments' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Author'.to_s, count: 2
    assert_select 'tr>td', text: 'Staff'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
  end
end
