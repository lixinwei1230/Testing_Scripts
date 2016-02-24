Given(/^I am on the bookstore login_page$/) do
	visit ui_url 'Login.jsp'
end

When(/^I login with "(.*?)" username and "(.*?)" password$/) do |username, password|
	fill_in 'Login', :with => username
	fill_in 'Password', :with => password
	click_button "Login"
end

Then(/^I should see "(.*?)"$/) do |arg|
	page.should have_content(arg)
	#expect(page).to have_content 'arg'
end

Then(/^I will go to login_page to logout$/) do
	visit ui_url 'Login.jsp'
end

Then(/^I want to logout$/) do
	click_button('Logout')
end