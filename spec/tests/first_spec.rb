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
        @zillow_search.listings { |listing|
          #TODO: scroll to listing before click
          listing.click
          sleep 2

          #TODO: check if no blocks
          @listing.agent_blocks.each {|block|
            agent_name = block.find('.profile-name-link').text
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
          @listing.close
          puts "<<<<<<<<<<<<<<<<<<<<<<<"
          puts agents
          puts ">>>>>>>>>>>>>>>>>>>>>>>"

        }

      end
  end
end