@javascript
Feature: Modify Discs
  In order to use the tracker
  As an editor
  I want to create and edit discs

	Scenario: Create a fully loaded disc
  		Given I am on the create disc page
      When I create a disc with all fields and associations
  		Then I should see the disc with associations on a display page

	Scenario: Edit an existing disc
      Given I am on the edit disc page
      When I edit the disc
  		Then I should see the changes on the disc display page

  Scenario: Delete a disc
      Given there is one disc
      And I am on the disc index page
      When I click on the delete link
      Then the index page is empty