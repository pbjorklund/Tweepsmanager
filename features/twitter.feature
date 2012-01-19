Feature: Signup with omniauth-twitter

	So that a user can access the sites functionality
	As a user
	I want to sign in with omniauth-twitter

	Scenario: Logging in
		Given I am not logged in
		When I go to the startpage
		And I click the "Sign in" link
		Then I should see "Signed in!"

	Scenario: Testing login
		Given I am signed in
		When I visit the startpage
		Then I should see my full name

	Scenario: Logout
		Given I am signed in
		When I click "Sign out"
		Then I should see "Signed out!"
