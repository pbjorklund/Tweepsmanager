Feature: Following / unfollowing of users

	This feature tests the behaviour of following / unfollowing users

	So that I can unfollow or follow tweeps
	As a user
	I want to display a list of my followers

	@logged_in
	Scenario:
		Given I am on the startpage
		When I go to the "followers" page
		Then I should see a list of my followers

	@logged_in
	Scenario:
		Given I am on the "followers" page
		When I click the button "Unfollow" for a user
		Then I should see "Stopped following"

	@logged_in
	Scenario:
		Given I am on the "followers" page
		When I click the button "Follow" for a user
		Then I should see "Followed"
