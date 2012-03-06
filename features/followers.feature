Feature: Following / unfollowing of users

	So that I can manage my twitter followers
	As a user
	I want to be able to follow and unfollow users

	@logged_in @javascript
	Scenario:
		Given I am on the "followers" page
		Then I should see a list of my followers

	@logged_in @javascript
	Scenario:
		Given I am on the "followers" page
    When I click the button "Unfollow" for "Tweepsmanager"
    Then the button text should be "Follow"

	@logged_in @javascript
	Scenario:
		Given I am on the "followers" page
		When I click the button "Follow" for "fewlines4biju"
    Then the button text should be "Unfollow"
