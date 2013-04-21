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
		saved = Place.create(:foursquare_id => params[:foursquare_id])
		current_user.places << saved 
		redirect_to(results_path(:address => params[:address]))
	end

	def favorites
		favorites_ids = current_user.places
		favorites_ids.map do |fav|
			client = Foursquare2::Client.new(:client_id => ENV["CLIENT_ID"], :client_secret => ENV["CLIENT_SECRET"])
			@favorites = client.venue(fav.foursquare_id)
			raise @favorites.inspect
		end
	end

	def comment
	end

	def send_email
		Mailer.form_email(params[:from], params[:subject], params[:body]).deliver
	end
end
