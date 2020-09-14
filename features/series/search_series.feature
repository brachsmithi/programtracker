@javascript
Feature: Search Series
  In order to use the tracker
  As a viewer
  I want to search series in order to make them easier to find

  Scenario: Searching series
      Given there are 5 pages of series
      And I am on the series index page
      When I run a search
      Then there are less than 2 pages on "Series Index" page

  Scenario: Maintaining series search on viewing
      Given I have run a series search
      And I have clicked to view an entry
      When I return to the series index page
      Then the series search still applies

  Scenario: Maintaining series search cancelling out of edit
      Given I have run a series search
      And I have clicked to edit an entry
      When I cancel out
      Then the series search still applies

  Scenario: Maintaining series search after editing
      Given I have run a series search
      And I edit an entry
      When I return to the series index page
      Then the series search still applies