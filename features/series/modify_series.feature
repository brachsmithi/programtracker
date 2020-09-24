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

	Scenario: Edit an existing series to be contained
      Given I am on the edit series page
      When I add a containing series
  		Then I should see the changes on the contained series display page

	Scenario: Edit an existing series that wraps another
      Given I am on the edit series page for a wrapper series
      When I edit the sequence of the contained series
  		Then I should see the changes on the wrapper series display page

  Scenario: Delete a series
      Given there is one series
      And I am on the series index page
      When I click on the delete link
      Then the index page is empty

  Scenario: Delete a contained series
      Given there is a contained series
      And I am on the series index page
      When I delete the contained series
      Then the contained series is gone 

  Scenario: Delete a wrapper series
      Given there is a contained series
      And I am on the series index page
      When I delete the wrapper series
      Then the wrapper series is gone 

	Scenario: Maintaining series pagination through editing
  		Given there are 2 pages of series
      And I am on page 2 of the series index
      And I edit an entry
      When I return to the series index page
      Then the pagination still applies

  Scenario: Deleting content from a series
      Given I am on the edit page of a series that has content
      When I delete the series content and save
      Then I should see that the series is empty