require 'selenium-webdriver'
require 'pry'

class Selenium::WebDriver::Element
  def children
    self.find_elements(:xpath, "./*")
  end
end

def a_single_tour
  # Driver setup
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to "https://spredfast.com/platform/intelligence/?env=kim-test"

  # SSO login
  elements = driver.find_elements(:class, "btn-primary")
  sso_login = elements[0]
  sso_login.click()
  email = driver.find_element(:name, 'email')
  email.send_keys 'dwene@spredfast.com'
  password = driver.find_element(:name, 'password')
  password.send_keys 'hackweek'
  submit = driver.find_element(:class, 'btn-primary')
  submit.click()

  # Now logged in
  sleep(5)

  # Skip tutorial
  hide_tutorial = driver.find_elements(:class, 'exit')
  hide_tutorial[0].click()

  # Enter the search bar
  search_input = driver.find_element(:css => ".searchBarInput input")

  hello_array = ['Ready?', 'Export to cloud', 'Hello', 'Hola', '您好', 'こんにちは']

  count = 0
  hello_array.each do |hello_string|
    search_input_array = hello_string.split('')
    
    char_count = 0
    
    search_input_array.each { |c|
    	sleep(0.1)
    	search_input.send_keys c
      
      # buffer time between phrases
      next if char_count != search_input_array.length - 1
      sleep(0.2)
    }.each { |c|
      sleep(0.1)

      # search for last phrase
      next if count == hello_array.length - 1
      search_input.send_keys("\b")
    }
    count += 1
  end


  # Search the last keyword in array
  search_input.send_keys(:enter) 
  sleep(3)


  # Make sure media content loaded
  search_input.send_keys(:arrow_down)
  search_input.send_keys(:arrow_down)


  # Click image for prank
  sleep(1)
  grab_firs_media_element = Proc.new {driver.find_elements(:css => '.media-0')}
  first_media_elements = retry_method(&grab_firs_media_element)
  first_media_element = first_media_elements[0]
  first_media_element.click()


  # Wait for modal to populate
  sleep(3)
  media_modal = driver.find_element(:css => '.modal-content')
  media_modal.click()


  # Close modal
  sleep(2)
  cancel_modal = driver.find_element(:css => '.close')
  cancel_modal.click()


  # Export to png
  # Click the export modal
  sleep(2)
  export_modal = driver.find_element(:css => '.export-dropdown')
  export_modal.click()


  # Click Export as PNG
  sleep(2)
  export_as_png = driver.find_elements(:css => '.export')[2]
  export_as_png.click()


  # Choose comprehensive view 
  sleep(2)
  export_png_as_comprehensive = driver.find_elements(:xpath, "//*[contains(text(), 'Comprehensive View')]")
  export_png_as_comprehensive[0].click()
  sleep(0.5)


  # Export now and wait for cloud modal
  export_png_now = driver.find_element(:css => '.modal-footer .btn')
  export_png_now.click()


  # Wait until it finish processing then cloud modal will pop out
  grab_filepicker_modal = Proc.new { driver.find_elements(:xpath, "//iframe[contains(@id, 'filepicker_dialog')]") }
  filepicker_modal = retry_method(&grab_filepicker_modal)
  filepicker_modal = filepicker_modal[0]
  filepicker_modal.click() # sanity check iframe exists


  # Switch to iframe and click Box Cloud
  driver.switch_to.frame(filepicker_modal)
  driver.find_elements(:css => ".sbicon-box")[0].click()
  puts "hooray llll"
  binding.pry

end

# Retry till the element exist
def retry_method(&block)
  ele_arr = nil
  while true do
    ele_arr = block.call
    break if ele_arr.length > 0
    sleep(1)
    puts 'checking >>>'
  end 
  ele_arr
end


a_single_tour()

# End of driver


# useful iframe handling
# driver.switch_to.default_content()
# driver.switch_to.frame(0) # can feed in id, object

