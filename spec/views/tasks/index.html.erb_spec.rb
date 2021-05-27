# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/index', type: :view do
  before(:each) do
    assign(
      :tasks,
      [
        Task.create!(
          name: 'Name_1',
          status: false
        ),
        Task.create!(
          name: 'Name_2',
          status: false
        )
      ]
    )
  end

  it 'renders a list of tasks' do
    render
    assert_select 'tr>td', text: 'Name_1'.to_s, count: 1
    assert_select 'tr>td', text: 'Name_2'.to_s, count: 1
    assert_select 'tr>td', text: '未完', count: 2
  end
end
