# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation

Before '@javascript' do
  page.driver.browser.manage.window.maximize
end


Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument '--headless'

  Capybara::Selenium::Driver.new app,browser: :chrome, options: options
end

if ENV["GITLAB_CI"]
  Capybara.default_driver = :headless_chrome
  Capybara.javascript_driver = :headless_chrome
else
  Capybara.default_driver = :selenium_chrome
  Capybara.javascript_driver = :selenium_chrome
end



World(FactoryBot::Syntax::Methods)