Given(/^I am going to register a new account$/) do
	visit ui_url 'Registration.jsp'
end

When(/^I fill in the new account info "(.*?)" for username "(.*?)" for password and "(.*?)" for firstname and "(.*?)" for the last name, my email address is "(.*?)"$/) do |arg1, arg2, arg3, arg4, arg5|
	fill_in 'member_login', :with => arg1
	fill_in 'member_password', :with => arg2
	fill_in 'member_password2', :with => arg2
	fill_in 'first_name', :with => arg3
	fill_in 'last_name', :with => arg4
	fill_in 'email', :with => arg5
	click_button "Register"
end

Then(/^I should login successful using "(.*?)" for username and "(.*?)" for password$/) do |arg1, arg2|
	#visit ui_url 'arg1'
	step %{I am on the bookstore login_page}
	fill_in 'Login', :with => arg1
	fill_in 'Password', :with => arg2
	click_button "Login"
	step %{I should see "User Information"}
end



