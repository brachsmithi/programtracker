@javascript
Feature: Modify Directors
  In order to use the tracker
  As an editor
  I want to create and edit directors

	Scenario: Create a fully loaded director
  		Given I am on the create director page
      When I create a director with alias
  		Then I should see the director with alias on a display page

	Scenario: Edit an existing director
      Given I am on the edit director page
      When I edit the director
  		Then I should see the changes on the director display page

  Scenario: Delete a director
      Given there is one director
      And I am on the director index page
      When I click on the delete link
      Then the index page is empty

	Scenario: Maintaining director pagination through editing
  		Given there are 2 pages of directors
      And I am on page 2 of the director index
      And I edit a director
      When I return to the director index page
      Then the director pagination still applies