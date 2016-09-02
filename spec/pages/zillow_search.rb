class ZillowSearch
  include Capybara::DSL

  def listings
    css_selector = '.zsg-photo-card-overlay-link'
    find_all(css_selector)
  end

  def next_page
    within find('.zsg-pagination') do
      begin
        find('.zsg-pagination_active+li').click
      rescue Capybara::ElementNotFound
        return "end"
      end
    end

  end

  def max_page
    attempt = 1
    begin
      within find('.zsg-pagination') do all('.zsg-pagination-ellipsis+li').last.text end
    rescue
      puts "can't find it, retrying #{attempt}"
      if attempt < 3
        attempt = attempt + 1
        retry
      end
    end
  end

  def current_page
    within find('.zsg-pagination') do find('.zsg-pagination_active').text end
  end

end