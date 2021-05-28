# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :remote_chrome
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 4444
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
end

# Chrome
Capybara.register_driver :remote_chrome do |app|
  # caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
  #   'goog:chromeOptions' => {
  #     'args' => [
  #       'no-sandbox',
  #       'headless',
  #       'disable-gpu',
  #       'window-size=1400,1000',
  #       'disable-dev-shm-usage',
  #       'whitelisted-ips'
  #     ]
  #   }
  # )
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args' => [
        '--no-default-browser-check',
        '--start-maximized',
        '--headless',
        '--disable-dev-shm-usage',
        '--whitelisted-ips'
      ],
      'prefs' => {
        'download.default_directory' => '/tmp/downloads',
        'download.directory_upgrade' => true,
        'download.prompt_for_download' => false
      }
    }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: 'http://chrome:4444/wd/hub',
    desired_capabilities: caps
  )
  # @session = Capybara::Session.new(:selenium_chrome_headless)
end
