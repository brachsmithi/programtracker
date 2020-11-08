@javascript
Feature: Modify Persons
  In order to use the tracker
  As an editor
  I want to create and edit persons

	Scenario: Create a fully loaded person
  		Given I am on the create person page
      When I create a person with alias
  		Then I should see the person with alias on a display page

	Scenario: Edit an existing person
      Given I am on the edit person page
      When I edit the person
  		Then I should see the changes on the person display page

  Scenario: Delete a person
      Given there is one person
      And I am on the person index page
      When I click on the delete link
      Then the index page is empty

	Scenario: Maintaining person pagination through editing
  		Given there are 2 pages of persons
      And I am on page 2 of the person index
      And I edit an entry
      When I return to the person index page
      Then the pagination still applies