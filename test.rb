require 'selenium-webdriver'
require 'pry'
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
# binding.pry

sleep(15)
driver.close()

