class UsersController < ApplicationController
	def index
		@mygames = current_user.managed_games.all
	
		respond_to do |format|
			format.html #index.html.erb
		end
	end
	
	def create_game
		respond_to do |format|
			format.html #create_game.html.erb
		end
	end
end
