@javascript
Feature: Modify Series
  In order to use the tracker
  As an editor
  I want to create and edit series

	Scenario: Create a series
  		Given I am on the create series page
      When I create a series
  		Then I should see the series on a display page

	Scenario: Edit an existing series
      Given I am on the edit series page
      When I edit the series
  		Then I should see the changes on the series display page

  Scenario: Delete a series
      Given there is one series
      And I am on the series index page
      When I click on the delete link
      Then the index page is empty