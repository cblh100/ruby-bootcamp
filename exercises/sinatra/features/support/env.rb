require 'capybara'
require 'capybara/cucumber'

require_relative '../../lib/bill_app'

Capybara.app = BillApp

#Capybara.default_driver = :selenium
