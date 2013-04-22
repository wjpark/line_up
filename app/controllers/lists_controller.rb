class ListsController < ApplicationController
	
	before_filter :store_location
	before_filter :authenticate_user!, :only => [:favorites, :save]

	def home
	end

	def results
		session[:search_results] = request.url
		@address = params[:address] || session[:address]
		session[:address] = params[:address] if params[:address]
		coordinates = Geocoder.coordinates(@address)
		client = Foursquare2::Client.new(:client_id => ENV["CLIENT_ID"], :client_secret => ENV["CLIENT_SECRET"])
		@venues = client.trending_venues(coordinates.join(","),{:limit => 10, :radius => 10000}).venues
	end

	def save
		saved = Place.create(:foursquare_id => params[:foursquare_id])
		current_user.places << saved
		redirect_to results_path
	end

	def favorites
		favorites_ids = current_user.places
		@favorites = favorites_ids.map do |fav|
			client = Foursquare2::Client.new(:client_id => ENV["CLIENT_ID"], :client_secret => ENV["CLIENT_SECRET"])
			client.venue(fav.foursquare_id)
		end
	end

	def delete
		@favorite = Place.find_by_foursquare_id(params[:foursquare_id])
		@favorite.destroy

		redirect_to favorites_url
	end

	def comment
	end

	def send_email
		Mailer.form_email(params[:from], params[:subject], params[:body]).deliver
	end
end
