Then /^I should see a page\-selector$/ do
  page.should have_selector 'li.page'
end

Then /^page "([^"]*)" should be active in the page\-selector$/ do |pagenum|
  page.should have_selector 'li.page.active', text: pagenum
end

Then /^I should see a link to "([^"]*)"$/ do |link|
  page.should have_link link, { href: "#" }
end
