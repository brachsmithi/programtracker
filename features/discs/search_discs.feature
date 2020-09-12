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