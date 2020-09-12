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