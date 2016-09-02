class ZillowSearch
  include Capybara::DSL

  def listings
    css_selector = '.zsg-photo-card-overlay-link'
    if block_given?
      find_all(css_selector).each {|listing|
        yield listing
      }
    else
      find_all(css_selector)
    end
  end

end