require 'selenium-webdriver'
require 'pry'

class Selenium::WebDriver::Element
  def children
    self.find_elements(:xpath, "./*")
  end
end


driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://spredfast.com/platform/intelligence/?env=kim-test"
elements = driver.find_elements(:class, "btn-primary")
sso_login = elements[0]
sso_login.click()
email = driver.find_element(:name, 'email')
email.send_keys 'dwene@spredfast.com'
password = driver.find_element(:name, 'password')
password.send_keys 'hackweek'
submit = driver.find_element(:class, 'btn-primary')
submit.click()

# now logged in

sleep(5)
hide_tutorial = driver.find_elements(:class, 'exit')
hide_tutorial[0].click()
search_input = driver.find_element(:css => ".searchBarInput input")
search_array = "Flaming Dumpster".split('')
search_array.each { |char|
	sleep(0.2)
	search_input.send_keys char
}

sleep(1.5)

search_array.each { |char|
	sleep(0.1)
	search_input.send_keys "\b"
}

sleep(0.5)
binding.pry
sleep(15)
# driver.close()

