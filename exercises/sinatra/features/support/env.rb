require 'capybara'
require 'capybara/cucumber'

require_relative '../../lib/bill_app'

Capybara.app = BillApp


Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

#Capybara.javascript_driver = :chrome

Capybara.default_driver = :chrome