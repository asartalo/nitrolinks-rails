Given(/^I am at the '([^']*)' page$/) do |name|
  step "I visit the '#{name}' page"
end

Given(/^I visit the '([^']*)' page$/) do |name|
  visit nitro_page(name)
  wait_for_page_load
end

When(/^I go back$/) do
  page.go_back
end

When(/^I go forward$/) do
  page.go_forward
end

When(/^I reload the page$/) do
  jscript('window.location.reload()')
end

When(/^I pause$/) do
  pause_pls
end

Then(/^I should see the '([^']*)' page$/) do |name|
  expect(page).to have_current_path(nitro_page(name))
end

Then(/^I should see '(.+)'$/) do |text|
  expect(page).to have_content(text)
end

