When /^I go to the "([^"]*)" page$/ do |page|
  VCR.use_cassette("#{page}") do
    visit "/#{page}"
  end
end

Then /^I should see a list of my followers$/ do
  page.should have_xpath('//table/tbody/tr/td/a')
end

Given /^I am on the "([^"]*)" page$/ do |page|
  VCR.use_cassette("#{page}") do
    visit "/#{page}"
  end
end

When /^I click the button "([^"]*)" for a user$/ do |button|
  VCR.use_cassette("button_click/#{button}") do
    click_button("#{button}")
  end
end
