require 'capybara/cucumber'

Capybara.default_driver = :selenium


$audiobook_collection_manager_ui_base_url = 'localhost:8080/bookstore/'
#$storra_rest_server_base_url              = 'http://localhost:1302/'

def ui_url(path)
  $audiobook_collection_manager_ui_base_url + path
end

def backend_url(path)
  $storra_rest_server_base_url + path
end

def login(username, password)
	visit ui_url 'Login.jsp'
	fill_in 'Login', :with => username
	fill_in 'Password', :with => password
	click_button "Login"	
end