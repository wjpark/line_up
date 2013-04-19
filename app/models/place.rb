class Place < ActiveRecord::Base
  attr_accessible :address, :checkins, :herenow, :icon, :name, :url, :foursquare_id

  has_many :favorites
  has_many :users, :through => :favorites

end
