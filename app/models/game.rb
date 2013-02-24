class Game < ActiveRecord::Base
  attr_accessible :description, :map_image, :name
  belongs_to :user

  validates :user_id, :presence => true
end
