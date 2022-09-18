# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'experiments/edit', type: :view do
  before(:each) do
    @experiment = assign(:experiment, Experiment.create!(
                                        title: 'MyString',
                                        author: 'MyString',
                                        staff: 'MyString',
                                        type: 1,
                                        status: 1
                                      ))
  end

  it 'renders the edit experiment form' do
    render

    assert_select 'form[action=?][method=?]', experiment_path(@experiment), 'post' do
      assert_select 'input[name=?]', 'experiment[title]'

      assert_select 'input[name=?]', 'experiment[author]'

      assert_select 'input[name=?]', 'experiment[staff]'

      assert_select 'input[name=?]', 'experiment[type]'

      assert_select 'input[name=?]', 'experiment[status]'
    end
  end
end
