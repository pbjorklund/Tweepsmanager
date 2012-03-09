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
