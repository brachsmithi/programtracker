@javascript
Feature: Search Programs
  In order to use the tracker
  As a viewer
  I want to search programs in order to make them easier to find

  Scenario: Searching programs
      Given there are 5 pages of programs
      And I am on the program index page
      When I run a search
      Then there are less than 2 pages on "Program Index" page

  Scenario: Maintaining program search on viewing
      Given I have run a program search
      And I have clicked to view an entry
      When I return to the program index page
      Then the program search still applies

  Scenario: Maintaining program search cancelling out of edit
      Given I have run a program search
      And I have clicked to edit an entry
      When I cancel out
      Then the program search still applies

  Scenario: Maintaining program search after editing
      Given I have run a program search
      And I edit an entry
      When I return to the program index page
      Then the program search still applies