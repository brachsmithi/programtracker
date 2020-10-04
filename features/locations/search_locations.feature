@javascript
Feature: Search Locations
  In order to use the tracker
  As a viewer
  I want to search locations in order to make them easier to find

  Scenario: Searching locations
      Given there are 5 pages of locations
      And I am on the location index page
      When I run a search
      Then there are less than 2 pages on "Location Index" page

  Scenario: Maintaining location search on viewing
      Given I have run a location search
      And I have clicked to view an entry
      When I return to the location index page
      Then the location search still applies

  Scenario: Maintaining location search cancelling out of edit
      Given I have run a location search
      And I have clicked to edit an entry
      When I cancel out
      Then the location search still applies

  Scenario: Maintaining location search after editing
      Given I have run a location search
      And I edit an entry
      When I return to the location index page
      Then the location search still applies