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