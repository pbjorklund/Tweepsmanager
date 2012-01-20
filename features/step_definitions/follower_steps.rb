When /^I go to the followers page$/ do
  VCR.use_cassette('followers') do
    visit "/twitter/followers"
  end
end

Then /^I should see a list of my followers$/ do
  page.should have_xpath('//table/tbody/tr/td/a')
end
