class ListsController < ApplicationController
	
	before_filter :authenticate_user!, :only => [:home]

	def home
		client = Foursquare2::Client.new(:client_id => '4B5MERQAYMRB5F4I535NEBDZRNN24UIUAUFSFNKWIXACNLUX', :client_secret => '0VLPK4IGM5IXJ245JTEOF5ARZSKUBU2ILZISYBSZB4RSMPWU')
		@venues = client.trending_venues('37.7750,-122.4183',{:limit => 11}).venues
	end

end
