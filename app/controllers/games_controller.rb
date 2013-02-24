class GamesController < ApplicationController
	def index
		respond_to do |format|
			format.html #index.html.erb
		end
	end
	
	def show
		@game = Game.find(params[:id])
		@locations = @game.locations.all
	
		respond_to do |format|
			format.html #show.html.erb
		end
	end
	
	def create
		respond_to do |format|
			format.html #create.html.erb
		end
	end
end
