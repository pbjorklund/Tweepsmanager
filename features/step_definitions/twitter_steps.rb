Before do
  OmniAuth.config.test_mode = true
  auth = OmniAuth.config.mock_auth[:twitter] = {
    provider: 'twitter',
    uid: '123545',
    :info => { name: 'Patrik Bjorklund', image_url: 'blank', nickname: 'pbjorklund' },
    :credentials => { token: 'blank', secret: 'blank' }
  }
end

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
