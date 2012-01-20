Given /^I am not logged in$/ do
end

When /^I go to the startpage$/ do
  visit root_path
end

When /^I click "([^"]*)"$/ do |link|
  click_link link
end

Then /^I should see "([^"]*)"$/ do |message|
  page.should have_content(message)
end

Given /^I am signed in$/ do
  visit root_path
  click_link "Sign in"
end
