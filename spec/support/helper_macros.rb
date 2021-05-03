
# frozen_string_literal: true

module HelperMacros
  def login(email, password)
    visit root_path
    # 入力フォームに情報を入力
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_button 'Log in'
  end
end
