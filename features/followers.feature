Feature: Followers

	So that I can unfollow or follow tweeps
	As a user
	I want to display a list of my followers

	Scenario:
		Given I am signed in
		When I go to the followers page
		Then I should see a list of my followers
