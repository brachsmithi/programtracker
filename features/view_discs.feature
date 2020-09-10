Feature: View Discs
  In order to use the tracker
  As a viewer
  I want to see the disc pages of my app

	Scenario: View discs page
  		Given I am on the disc index page
  		Then I should see "Disc Index"

	Scenario: Page through discs
  		Given there are 2 pages of discs
      And I am on the disc index page
      When I click on the next link
  		Then I should see the last page

  Scenario: Select a disc to see
      Given there is one disc
      And I am on the disc index page
      When I click on the show link
      Then I should see the disc page

  Scenario: Select a disc to edit
      Given there is one disc
      And I am on the disc index page
      When I click on the edit link
      Then I should see the disc edit page

  Scenario: Choose to create a disc
      Given I am on the disc index page
      When I click on the new disc button
      Then I should see the new disc page