Feature: Signup with omniauth-twitter

	So that a user can access the sites functionality
	As a user
	I want to sign in with omniauth-twitter

	Scenario: Logging in
		Given I am not logged in
		When I go to the startpage
		And I click "Sign in"
		Then I should see "Signed in!"

		@logged_in
	Scenario: Logout
		Given I am signed in
		When I go to the startpage
		And I click "Sign out"
		Then I should see "Signed out!"
