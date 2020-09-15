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