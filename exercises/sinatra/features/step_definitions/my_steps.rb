Given(/^I go to the home page$/) do
  visit '/'
end

Given(/^I have invalid credentials$/) do
  page.driver.browser.basic_authorize 'foo', 'bar'
end

Given(/^I have valid credentials$/) do
  page.driver.browser.basic_authorize 'username', 'password'
end


Then(/^I should be required to authenticate$/) do
  expect(page.status_code).to eq(401)
end

And(/^The authentication realm should be '(.+)'$/) do |realm|
  expect(page.response_headers).to include('WWW-Authenticate' => "Basic realm=\"#{realm}\"")
end

Then(/^I should see '(.+)'$/) do |word|
  expect(page).to have_content(word)
end

And(/^The page title should should be '(.+)'$/) do |title|
  expect(page.title).to eq(title)
end

