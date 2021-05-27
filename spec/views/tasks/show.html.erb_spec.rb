# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/show', type: :view do
  before(:each) do
    @task = assign(
      :task,
      Task.create!(
        name: 'Name',
        status: false
      )
    )
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/未完/)
  end
end
