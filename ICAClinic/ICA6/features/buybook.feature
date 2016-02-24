Feature: but two books in the bookstore

Scenario: Search for the website
	Given I want to buy a book
	When I have to go back to home page
	Then I clicked first book named "MySQL & PHP From Scratch"
	Then I clicked second book named "Web Database Development : Step by Step"
	Then I will see "63.98000144958496"