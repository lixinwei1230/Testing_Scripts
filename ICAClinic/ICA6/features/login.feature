Feature: login the bookstore

Scenario: Search for the website
	Given I am on the bookstore login_page
	When I login with "admin" username and "admin" password
	Then I should see "User Information"
	Then I will go to login_page to logout
	Then I want to logout