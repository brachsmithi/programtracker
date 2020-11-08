Feature: View Persons
  In order to use the tracker
  As a viewer
  I want to see the person pages of my app

	Scenario: View persons page
  		Given I am on the person index page
  		Then I should see "Person Index"

	Scenario: Page through persons
  		Given there are 2 pages of persons
      And I am on the person index page
      When I click on the next link
  		Then I should see the last page

  Scenario: Select a person to see
      Given there is one person
      And I am on the person index page
      When I click on the show link
      Then I should see the person page

  Scenario: Select a person to edit
      Given there is one person
      And I am on the person index page
      When I click on the edit link
      Then I should see the person edit page

  Scenario: Choose to create a person
      Given I am on the person index page
      When I click on the new person button
      Then I should see the new person page

	Scenario: Maintaining pagination through diaplaying person
  		Given there are 2 pages of persons
      And I am on page 2 of the person index
      And I have clicked to view an entry
      When I return to the person index page
      Then the pagination still applies

	Scenario: Maintaining pagination through cancelling person edit
  		Given there are 2 pages of persons
      And I am on page 2 of the person index
      And I have clicked to edit an entry
      When I cancel out
      Then the pagination still applies