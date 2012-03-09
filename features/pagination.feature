Feature: Pagination of users

  To avoid loading to many users
  I want to paginate the user table on the followers-page

	@logged_in @javascript
	Scenario:
		Given I am on the "followers" page
		Then I should see a page-selector
		Then page "1" should be active in the page-selector

	@logged_in @javascript
	Scenario:
		Given I am on the "followers" page
    When I click "Next" on a page with a user table
		Then page "2" should be active in the page-selector
    And I should see a link to "Prev"
    And I should see a link to "Next"

    #TODO
    #Given I am on the "followers/2" page
    #When I click "Prev"
    #Then page "1" should be active in the page-selector
    #And I should not see a link to "Prev"
