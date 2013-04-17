class ListsController < ApplicationController
	
	before_filter :authenticate_user!, :only => [:home]

	def home
		@users = User.all
	end

end
