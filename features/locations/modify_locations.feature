@javascript
Feature: Modify Locations
  In order to use the tracker
  As an editor
  I want to create and edit locations

	Scenario: Create a location
  		Given I am on the create location page
      When I create a location
  		Then I should see the location on a display page

	Scenario: Edit an existing location
      Given I am on the edit location page
      When I edit the location
  		Then I should see the changes on the location display page

	Scenario: Maintaining location pagination through editing
  		Given there are 2 pages of locations
      And I am on page 2 of the location index
      And I edit an entry
      When I return to the location index page
      Then the pagination still applies