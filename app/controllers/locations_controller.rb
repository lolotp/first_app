require 'aws-sdk'
require 'securerandom'

class LocationsController < ApplicationController
	def index
		@location = Location.new
	end
	
	def create
		respond_to do |format|
			@location = Location.new
			@location.location_info = params[:location][:location_info]
			game = Game.find_by_id(params[:location][:game_id])
			if game
				@location[:game_id] = game[:id]
				
				fileUp = params[:upload]
				orig_filename = fileUp['datafile'].original_filename
				filename = sanitize_filename(orig_filename) + SecureRandom.uuid
				s3 = ::AWS::S3.new
				b = s3.buckets.create(FirstApp::Application::BUCKET)
				o = b.objects[filename]
				o.write(fileUp['datafile'].read)
				@location.clue_file_name = filename
				
				if @location.save
					format.html { render:text => "successfully added location" }
				else
					format.html { render:text => "Error: invalid location information" }
				end
			else
				format.html { render:text => "Error: invalid game id" }
			end
			
		end
	end
	
private 
  
    def sanitize_filename(file_name)
      just_filename = File.basename(file_name)
      just_filename.sub(/[^\w\.\-]/,'_')
    end
end
