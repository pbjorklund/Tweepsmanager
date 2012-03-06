When /^I go to the "([^"]*)" page$/ do |target_page|
  visit "/#{target_page}"
end

Then /^I should see a list of my followers$/ do
  page.should have_xpath('//table/tbody/tr/td/a')
end

Given /^I am on the "([^"]*)" page$/ do |page|
  VCR.use_cassette("#{page}") do
    visit "/#{page}"
  end
end

When /^I click the button "([^"]*)" for "([^"]*)"$/ do |button, user|
  VCR.use_cassette("button_click/#{button}_for_#{user}") do
    button = page.find("#button-#{user}").find("input")
    button.click
    sleep(1) #Let the ajax call finish
  end
end

Then /^the button text should be "([^"]*)"$/ do |text|
  page.find("#button-Tweepsmanager").find("input").value.should == text
end
