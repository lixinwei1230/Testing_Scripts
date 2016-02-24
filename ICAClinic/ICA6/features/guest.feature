Feature: login the bookstore using guest

Scenario: Search for the website
	Given I am using "guest" and "guest" for login
	When I want to go to admin menu
	Then I want to see "Enter login and password"