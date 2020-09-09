Feature: View Programs
  In order to use the tracker
  As a viewer
  I want to see the programs page of my app

	Scenario: View programs page
  		Given I am on the "Programs" page
  		Then I should see "Program Index"

	Scenario: Page through programs
  		Given there are two pages of programs
      And I am on the "Programs" page
      And I click on the next link
  		Then I should see the last page