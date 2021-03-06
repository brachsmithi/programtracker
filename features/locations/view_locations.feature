Feature: View Locations
  In order to use the tracker
  As a viewer
  I want to see the location pages of my app

	Scenario: View locations page
  		Given I am on the location index page
  		Then I should see "Location Index"

	Scenario: Page through locations
  		Given there are 2 pages of locations
      And I am on the location index page
      When I click on the next link
  		Then I should see the last page

  Scenario: Select a location to see
      Given there is one location
      And I am on the location index page
      When I click on the show link
      Then I should see the location page

  Scenario: Select a location to edit
      Given there is one location
      And I am on the location index page
      When I click on the edit link
      Then I should see the location edit page

  Scenario: Choose to create a location
      Given I am on the location index page
      When I click on the new location button
      Then I should see the new location page

	Scenario: Maintaining pagination through diaplaying location
  		Given there are 2 pages of locations
      And I am on page 2 of the location index
      And I have clicked to view an entry
      When I return to the location index page
      Then the pagination still applies

	Scenario: Maintaining pagination through cancelling location edit
  		Given there are 2 pages of locations
      And I am on page 2 of the location index
      And I have clicked to edit an entry
      When I cancel out
      Then the pagination still applies