Given /^I am not logged in$/ do
end

When /^I go to the startpage$/ do
  visit root_path
end

When /^I click the "([^"]*)" link$/ do |link|
  OmniAuth.config.test_mode = true
  auth = OmniAuth.config.mock_auth[:twitter] = {
    provider: 'twitter',
    uid: '123545',
    :info => { name: 'Patrik Bjorklund', image_url: 'blank', nickname: 'pbjorklund' },
    :credentials => { token: 'blank', secret: 'blank' }
  }
  click_link link
end

Then /^I should see "([^"]*)"$/ do |signed_in|
  page.should have_content(signed_in)
end

Given /^I am signed in$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I visit the startpage$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see my full name$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I click "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
