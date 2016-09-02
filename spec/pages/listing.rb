require 'pry'
class Listing
  include Capybara::DSL

  def agent_blocks
    attempt = 1
    begin
      sleep 1
      form_id = '#lead-form_contact-tall'
      within form_id do
        all('.signature-refactor')
      end
    rescue Exception
      puts "coulnd't find element, retrying: #{attempt}"
      if attempt < 3
        attempt = attempt + 1
        retry
      else
        return []
      end
    end

  end

  def select_checkbox element

    begin
      id = element.first(:css, '.zsg-form-field_checkbox').native.find_element(:tag_name, 'input').attribute('id')
      execute_script("document.getElementById('#{id}').checked = true")
    rescue Selenium::WebDriver::Error::NoSuchElementError
    end
  end

  def fill_name name
    find(:css, '#name_contact-tall').send_keys name
  end

  def fill_phone phone
    find(:css, "#phone_contact-tall").send_keys phone
  end

  def fill_email email
    find(:css, "#email_contact-tall").send_keys email
  end

  def fill_message message
    el = find(:css, "#message_contact-tall")
    el.native.clear
    el.send_keys message
  end

  def close
    click_button 'Close'
  end

end