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
  		Then I should see the changes on the program display page

  Scenario: Delete a program
      Given there is one program
      And I am on the program index page
      When I click on the delete link
      Then the index page is empty

	Scenario: Maintaining program pagination through editing
  		Given there are 2 pages of programs
      And I am on page 2 of the program index
      And I edit an entry
      When I return to the program index page
      Then the pagination still applies

  Scenario: Create a new version from a clustered program
      Given that I am on the edit page for a program in a cluster
      When I choose to create a new version of the program
      And I save the new version of the program
      Then the new version of the program is in the program cluster

  Scenario: Create a new cluster from a program
      Given that I am on the edit page for a program not in a cluster
      When I choose to create a new version of the program
      And I save the new version of the program
      Then the new version of the program is in the program cluster