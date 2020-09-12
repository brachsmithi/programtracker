Feature: View Series
  In order to use the tracker
  As a viewer
  I want to see the series pages of my app

	Scenario: View series page
  		Given I am on the series index page
  		Then I should see "Series Index"

	Scenario: Page through series
  		Given there are 2 pages of series
      And I am on the series index page
      When I click on the next link
  		Then I should see the last page

  Scenario: Select a series to see
      Given there is one series
      And I am on the series index page
      When I click on the show link
      Then I should see the series page

  Scenario: Select a series to edit
      Given there is one series
      And I am on the series index page
      When I click on the edit link
      Then I should see the series edit page

  Scenario: Choose to create a series
      Given I am on the series index page
      When I click on the new series button
      Then I should see the new series page