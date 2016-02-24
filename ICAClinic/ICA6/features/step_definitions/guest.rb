Given(/^I am using "(.*?)" and "(.*?)" for login$/) do |arg1, arg2|
	visit ui_url 'Login.jsp'
	fill_in 'Login', :with => arg1
	fill_in 'Password', :with => arg2
	click_button "Login"
end

When(/^I want to go to admin menu$/) do
	visit ui_url 'AdminMenu.jsp'
end

Then(/^I want to see "(.*?)"$/) do |arg|
	page.should have_content(arg)
	#expect(page).to have_content 'arg'
end
