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
	
	def new
		@current_user = params[:user_id]
	end
	
	def create
		g = Game.new
		g.name = params[:name]
		g.description = params[:description]
		g.user = current_user
		
		fileUp = params[:upload]
		orig_filename = fileUp['datafile'].original_filename
		filename = sanitize_filename(orig_filename) + SecureRandom.uuid
		s3 = ::AWS::S3.new
		b = s3.buckets.create(FirstApp::Application::IMAGE_BUCKET)
		o = b.objects[filename]
		o.write(fileUp['datafile'].read)
		g.map_image = o.public_url(:secure =>false).to_s
		
		
			if g.save
				redirect_to "/users"
				#format.html { render :text => "Successfully created new game" + g.name + g.description + g.user.id.to_s }
			else
				respond_to do |format|
					format.html { render :text => "Failed to create new game. <a href=\"/users\">Click here</a> to go back to home page" }
				end
			end
		
	end
	
private 
    def sanitize_filename(file_name)
      just_filename = File.basename(file_name)
      just_filename.sub(/[^\w\.\-]/,'_')
    end
end
