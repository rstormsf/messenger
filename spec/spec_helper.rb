require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'
require 'selenium-webdriver'

# loading page object files
page_paths  = File.join(Dir.pwd, 'spec', 'pages', '*.rb')
Dir.glob(page_paths).each { |f| require f }

# overrides selenium's driver to use chrome browser
Capybara.register_driver :selenium do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome
  Capybara::Selenium::Driver.new(app, {detach: false,
                                       browser: :chrome,
                                       desired_capabilities: caps})
end

# selecting the driver
Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.before(:each) do
    config.include Capybara::DSL
    Capybara.default_max_wait_time = 3
    Capybara.default_driver = :selenium
  end
end