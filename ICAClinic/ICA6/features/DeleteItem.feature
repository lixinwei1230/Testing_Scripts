Feature: Delete one items and verify present

Background:
    Given I want to buy a book
	When I have to go back to home page
	Then I clicked first book named "MySQL & PHP From Scratch"
	Then I clicked second book named "Web Database Development : Step by Step"
	Then I will see "63.98000144958496"
   

Scenario: Modify shopping cart
   When I go to the shopping cart page
   And I delete a item
   And I go back to the shopping cart
   Then I should not see item "MySQL & PHP From Scratch"
