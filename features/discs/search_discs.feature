@javascript
Feature: Search Discs
  In order to use the tracker
  As a viewer
  I want to search discs in order to make them easier to find

  Scenario: Searching discs
      Given there are 5 pages of discs
      And I am on the disc index page
      When I run a search
      Then there are less than 2 pages on "Disc Index" page

  Scenario: Maintaining disc search on viewing
      Given I have run a disc search
      And I have clicked to view an entry
      When I return to the disc index page
      Then the disc search still applies

  Scenario: Maintaining disc search cancelling out of edit
      Given I have run a disc search
      And I have clicked to edit an entry
      When I cancel out
      Then the disc search still applies

  Scenario: Maintaining disc search after editing
      Given I have run a disc search
      And I edit an entry
      When I return to the disc index page
      Then the disc search still applies