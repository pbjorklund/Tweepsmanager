Given /^I am not logged in$/ do
end

When /^I go to the startpage$/ do
  visit root_path
end

When /^I click "([^"]*)"$/ do |link|
  VCR.use_cassette("#{link}") do
    click_link link
    sleep(7)
  end
end

Then /^I should see "([^"]*)"$/ do |message|
  page.should have_content(message)
end

Given /^I am signed in$/ do
end

Given /^I am on the startpage$/ do
  visit root_path
end

#Not in use
When /^I wait (\d+) seconds?$/ do |sec|
  sleep(sec.to_i)
end
