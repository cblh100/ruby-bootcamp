require 'pry'

Given(/^I go to the home page$/) do
  visit '/'
end

Given(/^I am on the home page$/) do
  step 'I go to the home page'
end

When(/^I provide a username of (\w+) and a password of (\w+)$/) do |username, password|
  fill_in 'username', with: username
  fill_in 'password', with: password
end

And(/^I click the (\w+) button$/) do |button|
  click_button button
end

Then(/^I should be sent to the login page$/) do
  step "The page title should should be 'Login'"
  expect(page).to have_field('username')
  expect(page).to have_field('password')
end

Then(/^I should see the failed login page$/) do
  step "The page title should should be 'Naughty naughty'"
end

Then(/^Then I should be able to view my bill$/) do
  step "The page title should should be 'Sky Bill'"
end

Given(/^I have logged in$/) do
  steps %(
    Given I go to the home page
    And I provide a username of username and a password of password
    And I click the Login button
    Then The page title should should be 'Sky Bill'
  )
end

Then(/^I should see '(.+)'$/) do |word|
  expect(page).to have_content(word)
end

And(/^The page title should should be '(.+)'$/) do |title|
  expect(page.title).to eq(title)
end

And(/^The page header is '(.+)'$/) do |header|
  expect(page).to have_css('.page-header h1', text: header)
end

And(/^The bill total is '£(\d+\.\d{2})'$/) do |amount|
  expect(page).to have_css('.well:last-child .row h4', text: amount)
end


Then(/^The (\w+) panel exists$/) do |panel|
  expect(page).to have_css("##{panel}", visible: false)
end

And(/^The (\w+) panel is collapsed$/) do |panel|
  element = page.find_by_id(panel, visible: false)
  expect(element['class']).to eq('panel-collapse collapse')
end

When(/^I click the (\w+) panel header$/) do |panel|
  element = page.find("##{panel} h3.panel-title a")
  element.click
end

And(/^The (\w+) panel expands/) do |panel|
  expect(page).to have_css("##{panel}.in", visible: false)
end