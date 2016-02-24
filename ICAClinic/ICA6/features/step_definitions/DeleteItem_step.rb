When(/^I go to the shopping cart page$/) do
   visit('http://localhost:8080/bookstore/ShoppingCart.jsp')
end

When(/^I delete a item$/) do
   page.find(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[3]/td[1]/a').click
   click_button('Delete')
   page.driver.browser.switch_to.alert.accept
end

When(/^I go back to the shopping cart$/) do
   visit('http://localhost:8080/bookstore/ShoppingCart.jsp')
end

Then(/^I should not see item "([^"]*)"$/) do |arg1|
   page.should have_no_content(arg1)
end

