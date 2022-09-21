# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'samples/edit', type: :view do
  before(:each) do
    @sample = assign(:sample, Sample.create!(
                                title: 'MyString',
                                category: 1
                              ))
  end

  it 'renders the edit sample form' do
    render

    assert_select 'form[action=?][method=?]', sample_path(@sample), 'post' do
      assert_select 'input[name=?]', 'sample[title]'

      assert_select 'input[name=?]', 'sample[category]'
    end
  end
end
