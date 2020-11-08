@javascript
Feature: Search Persons
  In order to use the tracker
  As a viewer
  I want to search persons in order to make them easier to find

  Scenario: Searching persons
      Given there are 5 pages of persons
      And I am on the person index page
      When I run a search
      Then there are less than 2 pages on "Person Index" page

  Scenario: Maintaining person search on viewing
      Given I have run a person search
      And I have clicked to view an entry
      When I return to the person index page
      Then the person search still applies

  Scenario: Maintaining person search cancelling out of edit
      Given I have run a person search
      And I have clicked to edit an entry
      When I cancel out
      Then the person search still applies

  Scenario: Maintaining person search after editing
      Given I have run a person search
      And I edit an entry
      When I return to the person index page
      Then the person search still applies
