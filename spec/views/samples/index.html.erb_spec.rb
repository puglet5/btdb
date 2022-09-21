# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'samples/index', type: :view do
  before(:each) do
    assign(:samples, [
             Sample.create!(
               title: 'Title',
               category: 2
             ),
             Sample.create!(
               title: 'Title',
               category: 2
             )
           ])
  end

  it 'renders a list of samples' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
