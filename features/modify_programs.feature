@javascript
Feature: Modify Programs
  In order to use the tracker
  As an editor
  I want to create and edit programs

	Scenario: Create a simple program
  		Given I am on the create program page
      And I create a program with all of the basic fields
  		Then I should see the program basics on a display page

	Scenario: Create a fully loaded program
  		Given I am on the create program page
      And I create a program with all associations
  		Then I should see the program with associations on a display page

