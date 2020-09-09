@javascript
Feature: Modify Programs
  In order to use the tracker
  As an editor
  I want to create and edit programs

	Scenario: Create a fully loaded program
  		Given I am on the create program page
      When I create a program with all fields and associations
  		Then I should see the program with associations on a display page

	Scenario: Edit an existing program
      Given I am on the edit program page
      When I edit the program
  		Then I should see the changes on a display page

  Scenario: Delete a program
      Given there is one program
      And I am on the program index page
      When I click on the delete link
      Then the program index page is empty