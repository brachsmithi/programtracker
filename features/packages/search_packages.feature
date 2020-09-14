@javascript
Feature: Search Packages
  In order to use the tracker
  As a viewer
  I want to search packages in order to make them easier to find

  Scenario: Searching packages
      Given there are 5 pages of packages
      And I am on the package index page
      When I run a search
      Then there are less than 2 pages on "Package Index" page

  Scenario: Maintaining package search on viewing
      Given I have run a package search
      And I have clicked to view an entry
      When I return to the package index page
      Then the package search still applies

  Scenario: Maintaining package search cancelling out of edit
      Given I have run a package search
      And I have clicked to edit an entry
      When I cancel out
      Then the package search still applies

  Scenario: Maintaining package search after editing
      Given I have run a package search
      And I edit an entry
      When I return to the package index page
      Then the package search still applies