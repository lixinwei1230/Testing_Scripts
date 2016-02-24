Given(/^I am on the bookstore default_page$/) do
	visit ui_url 'Default.jsp'
end

When(/^I search the book "([^"]*)"$/) do |arg1|
	fill_in 'name', :with => arg1
	click_button "Search"
end

Then(/^I could see "(.*?)" and "(.*?)"$/) do |arg2 , arg3|
	page.should have_content(arg2)
	page.should have_content(arg3)
end