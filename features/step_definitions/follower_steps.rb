When /^I go to the followers page$/ do
  visit "/twitter/followers"
end

Then /^I should see a list of my followers$/ do
  save_and_open_page
end
