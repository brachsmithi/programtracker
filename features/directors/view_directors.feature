Feature: View Directors
  In order to use the tracker
  As a viewer
  I want to see the director pages of my app

	Scenario: View directors page
  		Given I am on the director index page
  		Then I should see "Director Index"

	Scenario: Page through directors
  		Given there are 2 pages of directors
      And I am on the director index page
      When I click on the next link
  		Then I should see the last page

  Scenario: Select a director to see
      Given there is one director
      And I am on the director index page
      When I click on the show link
      Then I should see the director page

  Scenario: Select a director to edit
      Given there is one director
      And I am on the director index page
      When I click on the edit link
      Then I should see the director edit page

  Scenario: Choose to create a director
      Given I am on the director index page
      When I click on the new director button
      Then I should see the new director page