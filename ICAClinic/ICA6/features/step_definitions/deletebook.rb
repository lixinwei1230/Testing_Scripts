Given(/^I want to delete one book$/) do
	step %{I am on the bookstore login_page}
	step %{I login with "admin" username and "admin" password}
	step %{I should see "User Information"}
end

When(/^I clicked details link "(.*?)" for MySQL & PHP From Scratch$/) do |arg1|
	visit ui_url "ShoppingCartRecord.jsp?order_id=5&"
	#click_link(arg1)
end

Then(/^I delete the book MySQL$/) do
	find(:path, "//html/body/table[2]/tbody/tr/td/table/tbody/tr[3]/td[1]/a").click
	click_button("Delete")
	begin
		popup = page.driver.browser.window_handles
		within_window(popup) do
			click_button("OK")
		end
	rescue
	end
end



	


