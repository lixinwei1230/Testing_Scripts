Given(/^I want to buy a book$/) do
	step %{I am on the bookstore login_page}
	step %{I login with "admin" username and "admin" password}
	step %{I should see "User Information"}
end

When(/^I have to go back to home page$/) do
	visit ui_url 'Default.jsp'
end

Then(/^I clicked first book named "(.*?)"$/) do |arg1|
	#visit ui_url 'arg1'
	click_link(arg1)
	click_button("Add to Shopping Cart")
end

Then(/^I clicked second book named "(.*?)"$/) do |arg1|
	step %{I have to go back to home page}
	click_link(arg1)
	click_button("Add to Shopping Cart")
end

Then(/^I will see "([^"]*)"$/) do |arg|
	#expect(page).to have_content 'arg'
	visit ui_url 'ShoppingCart.jsp'
	page.should have_content(arg)
end



	


