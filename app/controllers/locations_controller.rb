require 'aws-sdk'
require 'securerandom'

class LocationsController < ApplicationController
	def index
		@location = Location.new
	end
	
	def new
		@game_id = params[:game_id]
		@url = Game.find_by_id(@game_id).map_image
	end
	
	def create
		respond_to do |format|
			@location = Location.new
			@location.location_info = params[:location][:location_info]
			game = Game.find_by_id(params[:location][:game_id])
			if game
				@location[:game_id] = game[:id]
				@location[:map_x_coordinates] = params[:x_coord]
				@location[:map_y_coordinates] = params[:y_coord]
				@location[:next_hint] = params[:location][:next_hint]
				
				fileUp = params[:upload]
				orig_filename = fileUp['datafile'].original_filename
				filename = sanitize_filename(orig_filename) + SecureRandom.uuid
				s3 = ::AWS::S3.new
				b = s3.buckets.create(FirstApp::Application::BUCKET)
				o = b.objects[filename]
				o.write(fileUp['datafile'].read)
				@location.clue_file_name = filename
				
				if @location.save
					@counter = 1
					
					while @counter>0 do
						@mac_name = "MAC" + @counter.to_s
						@signal_str = "signal_strength" + @counter.to_s
						
						if params[@mac_name] == nil
							@counter = 0
						else
							@counter += 1
							p = @location.point_coordinates.build
							p.MAC = params[@mac_name]
							p.signal_str = params[@signal_str]
							p.save
							
						end
					end
					
					format.html { render:text => "successfully added location" }
				else
					format.html { render:text => "Error: invalid location information" }
				end
			else
				format.html { render:text => "Error: invalid game id" }
			end
			
		end
	end
	
	def destroy
		@location = Location.find(params[:id])
		@game_id = @location.game_id
		@location.destroy
		
		redirect_to "/games/" + @game_id.to_s
		#respond_to do |format|
		#  format.html { redirect_to "/games/" + @game_id.to_s }
		#  format.json { head :no_content }
		#end
	end
	
private 
  
    def sanitize_filename(file_name)
      just_filename = File.basename(file_name)
      just_filename.sub(/[^\w\.\-]/,'_')
    end
	
	
end
