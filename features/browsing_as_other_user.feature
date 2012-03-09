Feature: Browsing as another user

  So that I can find new people
	As a user
  I want to be able to see other users connections

	@logged_in @javascript
	Scenario:
		Given I am on the "followers/pbjorklund" page
    When I click "Next" on a page with a user table as another user
		Then I should see a list of users
