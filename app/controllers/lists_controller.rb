class ListsController < ApplicationController
	
	#before_filter :authenticate_user!, :only => [:my_lists]

	def home
	end

	def results
		address = params[:address]
		coordinates = Geocoder.coordinates(address)
		#raise request.location.inspect
		#raise coordinates.inspect
		client = Foursquare2::Client.new(:client_id => '4B5MERQAYMRB5F4I535NEBDZRNN24UIUAUFSFNKWIXACNLUX', :client_secret => '0VLPK4IGM5IXJ245JTEOF5ARZSKUBU2ILZISYBSZB4RSMPWU')
		@venues = client.trending_venues(coordinates.join(","),{:limit => 11}).venues
	end

end
