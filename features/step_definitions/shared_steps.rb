# encoding: utf-8
Given /^I am not logged in$/ do
end

When /^I go to the startpage$/ do
  visit root_path
end

When /^I click "([^"]*)" on a page with a user table$/ do |link|
  VCR.use_cassette("#{link}") do
    click_link link

    wait_until do
      find(:xpath, '//table/tbody/tr/td/a')
    end
  end
end

When /^I click "([^"]*)"$/ do |link|
  VCR.use_cassette("#{link}") do
    click_link link
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
