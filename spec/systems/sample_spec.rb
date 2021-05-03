# frozen_string_literal: true

RSpec.describe 'sample', type: :system, js: true do
  let(:user_email) { 'guet@examole.com' }
  let(:user_password) { 'guest1234' }
  let!(:user) do
    create(:user, email: user_email, password: user_password, password_confirmation: user_password)
  end

  before { login user_email, user_password }

  scenario 'sample scenario' do
    # ルートページ内容
    visit root_path
    expect(current_path).to eq root_path
    expect(page).to have_content 'こんにちは'
    page.driver.save_screenshot 'screenshots/root.png'
  end

  scenario 'sample failer scenario' do
    # tmp/scrennshots/ に失敗時のスクリーンショットが保存される、
    visit root_path
    # わざと失敗させてみる
    expect(page).to have_content 'こんばんは'
  end
end
