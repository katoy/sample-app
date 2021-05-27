# frozen_string_literal: true

require 'csv'
require 'fileutils'

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
    # expect(page).to have_content 'こんばんは' # わざと失敗させてみる
    expect(page).to have_content 'こんにちは'
  end

  describe 'download' do
    let!(:tasks) { create_list :task, 2 }
    let(:csv_file_path) { '/tmp/downloads/tasks.csv' }
    let(:expected_csv) {
      [
        ['id', '名前', 'ステータス'],
        [tasks[1].id.to_s, tasks[1].name, 'false'],
        [tasks[0].id.to_s, tasks[0].name, 'false']
      ]
    }

    before(:each) do
      Dir.chdir '/tmp/downloads'
      FileUtils.rm_f(csv_file_path)
    end

    scenario 'download csv' do
      visit tasks_path(format: :csv)
      sleep 3 # ダウンロードが終わるのを少し待つ。
      expect(File.exist?(csv_file_path)).to match true
      expect(CSV.read(csv_file_path, headers: true).to_a).to eq expected_csv
    end
  end
end
