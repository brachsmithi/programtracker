@javascript
Feature: Search Directors
  In order to use the tracker
  As a viewer
  I want to search directors in order to make them easier to find

  Scenario: Searching directors
      Given there are 5 pages of directors
      And I am on the director index page
      When I run a search
      Then there are less than 2 pages on "Director Index" page

  Scenario: Maintaining director search on viewing
      Given I have run a director search
      And I have clicked to view a director view page
      When I return to the director index page
      Then the director search still applies

  Scenario: Maintaining director search cancelling out of edit
      Given I have run a director search
      And I have clicked to edit a director
      When I cancel out
      Then the director search still applies

  Scenario: Maintaining director search after editing
      Given I have run a director search
      And I edit a director
      When I return to the director index page
      Then the director search still applies
