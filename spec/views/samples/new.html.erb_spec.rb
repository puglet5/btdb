# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'samples/new', type: :view do
  before(:each) do
    assign(:sample, Sample.new(
                      title: 'MyString',
                      category: 1
                    ))
  end

  it 'renders new sample form' do
    render

    assert_select 'form[action=?][method=?]', samples_path, 'post' do
      assert_select 'input[name=?]', 'sample[title]'

      assert_select 'input[name=?]', 'sample[category]'
    end
  end
end
