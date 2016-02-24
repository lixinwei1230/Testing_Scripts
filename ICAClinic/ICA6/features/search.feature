Feature: search books in bookstore.jsp

Scenario: Search for the website
	Given I am on the bookstore default_page
	When I search the book "MySQL & PHP From Scratch"
	Then I could see "Search Results" and "23.99"
