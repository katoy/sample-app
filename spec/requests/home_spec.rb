# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /' do
    context 'before login' do
      it "ログイン画面が表示される" do
        get root_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'after login' do
      let(:user) { create :user }
      before { sign_in user }

      it "挨拶文が表示される" do
        get root_path
        expect(response).to have_http_status(200)
        expect(response.body).to include 'こんにちは'
      end
    end
  end
end
