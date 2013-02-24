class Location < ActiveRecord::Base
  attr_accessible :id, :location_info
  has_many :point_coordinates
  belongs_to :games
end
