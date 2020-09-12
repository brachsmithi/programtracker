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