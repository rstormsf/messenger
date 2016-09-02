require 'spec_helper'
require 'pry'

describe 'Zillow web site' do
  describe 'on Zillow search' do
      before(:each) do
        visit('http://www.zillow.com/homes/for_sale/Sarasota-FL/fsba_lt/20362_rid/globalrelevanceex_sort/27.458016,-82.178764,27.118118,-82.673149_rect/10_zm/0_mmm/')
        @zillow_search = ZillowSearch.new
        @listing = Listing.new
      end

      it 'sends a message to each agent' do
        agents = []
        max_page = @zillow_search.max_page
        while @zillow_search.current_page != max_page
          sleep 1
          puts "current page: #{@zillow_search.current_page} max: #{max_page}"
          # Starts main action
          listings_size = @zillow_search.listings.size
          while listings_size > 0
            puts "items left to go on this page: #{listings_size}"
            listing = @zillow_search.listings.at(listings_size - 1)
            listing.native.location_once_scrolled_into_view
            sleep 1
            listing.click
            sleep 1

            blocks = @listing.agent_blocks
            unless blocks.size.zero?
              @listing.agent_blocks.each {|block|
                agent_name = block.find('.name').text
                if agents.include? agent_name
                  next
                else
                  @listing.select_checkbox block
                  agents << agent_name
                end
              }
              @listing.fill_name 'name name'
              @listing.fill_phone '+14151231234'
              @listing.fill_email 'email@emai.com'
              @listing.fill_message 'message'
            end
            @listing.close
            listings_size = listings_size - 1
            puts "Served #{agents.size} agents"
          end
          # Ends Main Action

          @zillow_search.next_page
        end

        puts "Served #{agents.size} agents"
        expect(agents.uniq.size).to eq agents.size
        expect(listings_size).to eq 0

      end
  end
end
