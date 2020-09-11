Feature: View Program Version Clusters
  In order to use the tracker
  As a viewer
  I want to see the program version cluster pages of my app

	Scenario: View program version clusters page
  		Given I am on the program version cluster index page
  		Then I should see "Program Version Cluster Index"

	Scenario: Page through program version clusters
  		Given there are 2 pages of program version clusters
      And I am on the program version cluster index page
      When I click on the next link
  		Then I should see the last page

  Scenario: Select a program version cluster to see
      Given there is one program version cluster
      And I am on the program version cluster index page
      When I click on the show link
      Then I should see the program version cluster page

  Scenario: Select a program version cluster to edit
      Given there is one program version cluster
      And I am on the program version cluster index page
      When I click on the edit link
      Then I should see the program version cluster edit page

  Scenario: Choose to create a program version cluster
      Given I am on the program version cluster index page
      When I click on the new program version cluster button
      Then I should see the new program version cluster page