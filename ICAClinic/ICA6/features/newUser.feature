Feature: login the bookstore

Scenario: Search for the website
	Given I am going to register a new account
	When I fill in the new account info "xinwei" for username "123" for password and "Xinwei" for firstname and "Li" for the last name, my email address is "lixinwei1230@gmail.com"
	Then I should login successful using "xinwei" for username and "123" for password