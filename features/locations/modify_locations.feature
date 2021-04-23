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

    Scenario: Mark a location as filled
      Given I am on the edit location page
      When I mark the location as filled
      Then I should see the status as filled on the location display page

    Scenario: Mark a location as no longer filled
      Given I am on the edit filled location page
      When I mark the location as not filled
      Then I should see the status as not filled on the location display page

	Scenario: Maintaining location pagination through editing
  		Given there are 2 pages of locations
      And I am on page 2 of the location index
      And I edit an entry
      When I return to the location index page
      Then the pagination still applies