When /^I click "([^"]*)" on a page with a user table as another user$/ do |link|
  VCR.use_cassette("browsing_as_another_user#{link}") do
    click_link link

    wait_until { has_css?(".user-row") }
  end
end
