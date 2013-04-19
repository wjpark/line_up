class ListsController < ApplicationController
	
	before_filter :authenticate_user!, :only => [:favorites]

	def home
	end

	def results
		@address = params[:address]
		coordinates = Geocoder.coordinates(@address)
		#raise request.location.inspect
		#raise coordinates.inspect
		client = Foursquare2::Client.new(:client_id => ENV["CLIENT_ID"], :client_secret => ENV["CLIENT_SECRET"])
		@venues = client.trending_venues(coordinates.join(","),{:limit => 10, :radius => 10000}).venues
	end

	def save
		@saved = Place.create(:foursquare_id => params[:place][:foursquare_id])
		redirect_to(results_path(:address => params[:address]))
	end

	def favorites
		@favorites = Favorite.all
		@places = Place.all
	end
end
