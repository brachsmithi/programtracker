Feature: View Packages
  In order to use the tracker
  As a viewer
  I want to see the package pages of my app

	Scenario: View packages page
  		Given I am on the package index page
  		Then I should see "Package Index"

	Scenario: Page through packages
  		Given there are 2 pages of packages
      And I am on the package index page
      When I click on the next link
  		Then I should see the last page

  Scenario: Select a package to see
      Given there is one package
      And I am on the package index page
      When I click on the show link
      Then I should see the package page

  Scenario: Select a package to edit
      Given there is one package
      And I am on the package index page
      When I click on the edit link
      Then I should see the package edit page

  Scenario: Choose to create a package
      Given I am on the package index page
      When I click on the new package button
      Then I should see the new package page

	Scenario: Maintaining pagination through diaplaying package
  		Given there are 2 pages of packages
      And I am on page 2 of the package index
      And I have clicked to view an entry
      When I return to the package index page
      Then the pagination still applies

	Scenario: Maintaining pagination through cancelling package edit
  		Given there are 2 pages of packages
      And I am on page 2 of the package index
      And I have clicked to edit an entry
      When I cancel out
      Then the pagination still applies