@javascript
Feature: Modify Packages
  In order to use the tracker
  As an editor
  I want to create and edit packages

	Scenario: Create a package
  		Given I am on the create package page
      When I create a package
  		Then I should see the package on a display page

	Scenario: Edit an existing package
      Given I am on the edit package page
      When I edit the package
  		Then I should see the changes on the package display page

	Scenario: Edit an existing package to be contained
      Given I am on the edit package page
      When I add a containing package
  		Then I should see the changes on the contained package display page

	Scenario: Edit an existing package that wraps another
      Given I am on the edit package page for a wrapper package
      When I edit the sequence of the contained package
  		Then I should see the changes on the wrapper package display page

  Scenario: Delete a package
      Given there is one package
      And I am on the package index page
      When I click on the delete link
      Then the index page is empty

  Scenario: Delete a contained package
      Given there is a contained package
      And I am on the package index page
      When I delete the contained package
      Then the contained package is gone 

  Scenario: Delete a wrapper package
      Given there is a contained package
      And I am on the package index page
      When I delete the wrapper package
      Then the wrapper package is gone 

	Scenario: Maintaining package pagination through editing
  		Given there are 2 pages of packages
      And I am on page 2 of the package index
      And I edit an entry
      When I return to the package index page
      Then the pagination still applies