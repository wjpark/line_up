class ListsController < ApplicationController
	
	before_filter :authenticate_user!, :only => [:login]

	def login
	end

end
