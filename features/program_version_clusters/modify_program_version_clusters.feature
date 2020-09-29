@javascript
Feature: Modify Program Version Clusters
  In order to use the tracker
  As an editor
  I want to create and edit program version clusters

	Scenario: Create a program version cluster with programs
  		Given I am on the create program version cluster page
      When I create a program version cluster with associations
  		Then I should see the program version cluster with associations on a display page

	Scenario: Edit an existing program version cluster
      Given I am on the edit program version cluster page
      When I edit the program version cluster
  		Then I should see the changes on the program version cluster display page

  Scenario: Delete a program version cluster
      Given there is one program version cluster with program
      And I am on the program version cluster index page
      When I click on the delete link
      Then the index page is empty

	Scenario: Maintaining program version cluster pagination through editing
  		Given there are 2 pages of program version clusters
      And I am on page 2 of the program version cluster index
      And I edit an entry
      When I return to the program version cluster index page
      Then the pagination still applies

  Scenario: Editing all programs in a version cluster
      Given I am on the edit page for a cluster with two programs
      When I edit the program fields
      Then the cluster changes should be visible on the first program
      And the cluster changes should be visible on the second program

  Scenario: Removing a program from a version cluster
      Given I am on the edit page for a cluster with two programs
      When I remove a project from the cluster
      Then the program should not be on the cluster display
      And the removed program should still exist