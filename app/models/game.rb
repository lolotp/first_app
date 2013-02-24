class Game < ActiveRecord::Base
  attr_accessible :description, :map_image, :name
  belongs_to :user

  has_many :game_user_relations
  has_many :game_users, 
           :through => :game_user_relations,
	   :source => :user

  validates :user_id, :presence => true
end
