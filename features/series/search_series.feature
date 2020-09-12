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