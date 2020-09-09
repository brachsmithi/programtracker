Feature: View Programs
  In order to use the tracker
  As a viewer
  I want to see the program pages of my app

	Scenario: View programs page
  		Given I am on the program index page
  		Then I should see "Program Index"

	Scenario: Page through programs
  		Given there are 2 pages of programs
      And I am on the program index page
      When I click on the next link
  		Then I should see the last page

  Scenario: Select a program to see
      Given there is one program
      And I am on the program index page
      When I click on the show link
      Then I should see the program page

  Scenario: Select a program to edit
      Given there is one program
      And I am on the program index page
      When I click on the edit link
      Then I should see the program edit page

  Scenario: Choose to create a program
      Given I am on the program index page
      When I click on the new program button
      Then I should see the new program page