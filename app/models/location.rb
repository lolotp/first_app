class Location < ActiveRecord::Base
  attr_accessible :id, :location_info, :map_x_coordinates, :map_y_coordinates, :clue_file_name, :next_hint
  has_many :point_coordinates
  belongs_to :games

  has_many :user_location_relations
  has_many :users, :through => :user_location_relations
end
