# encoding: utf-8

Given /^I am signed in$/ do
end

Given /^I am on the startpage$/ do
  visit root_path
end

Given /^I am on the "([^"]*)" page$/ do |target_page|
  VCR.use_cassette("#{target_page.gsub("/","-")}") do
    visit "/#{target_page}"

    wait_until do
      find(:xpath, '//table/tbody/tr/td/a')
    end
  end
end

Given /^I am not logged in$/ do
end

When /^I go to the startpage$/ do
  visit root_path
end

When /^I go to the "([^"]*)" page$/ do |target_page|
  visit "/#{target_page}"
end

When /^I click "([^"]*)" on a page with a user table$/ do |link|
  VCR.use_cassette("#{link}") do
    click_link link

    wait_until { has_css?(".user-row") }
  end
end

When /^I click "([^"]*)"$/ do |link|
  VCR.use_cassette("#{link}") do
    click_link link
  end
end

Then /^I should see a list of users$/ do
  page.should have_xpath('//table/tbody/tr/td/a')
end

Then /^I should see "([^"]*)"$/ do |message|
  page.should have_content(message)
end
