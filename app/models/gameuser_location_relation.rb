class GameuserLocationRelation < ActiveRecord::Base
  belongs_to :game_user_relation
  belongs_to :location
end
