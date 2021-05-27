# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  describe 'index' do
    it 'renders a list of tasks' do
      render

      expect(rendered).to match(/こんにちは/)
    end
  end
end
