class GameUserController < ApplicationController
  def get_user_id_from_security_token(token)
    begin
        tokens = token.split
        id = Integer(tokens[0])
        u = User.find_by_id(id)
        if (tokens[1] == u[:password_digest])                
            u[:id]
        else
            -1
        end
    rescue ArgumentError
        -1
    end 
  end
  
  def login
    user = User.find_by_email(params[:email].downcase)
    respond_to do |format|
      if user && user.authenticate(params[:password])
        format.html { render :text => user[:id].to_s()+" "+user[:password_digest] }
      else
        format.html { render :text => "Error: Invalid email/password", :status => 401}
      end
    end
  end

  def register
	user = User.new(:name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
	respond_to do |format|
	  if user
		if user.save
		  format.html { render :text => "Successfully registered." }
		else
		  format.html { render :text => "Error: User already exists." }
		end
	  else
		format.html { render :text => "Error: Failed to register." }
	  end
	end
  end

  def games
    @user = User.find_by_id( get_user_id_from_security_token (params[:security_token]) )
    respond_to do |format|
        if @user
            format.html { render :json => @user.games }
        else
            format.html { render :text => "Error: Invalid security token", :status => 401}
        end
    end
  end

  def game_status
    user = User.find_by_id( get_user_id_from_security_token (params[:security_token]) )
    respond_to do |format|
        if (user)
            game = user.games.find_by_id( params[:game_id] )
            if (game)
                format.json { render :json => user.locations.where("game_id = ?",params[:game_id]) }
            else
                format.html { render :text => "Error: Invalid game id", :status => 400}
            end
        else
            format.html { render :text => "Error: Invalid security token", :status => 401}
        end
    end
  end

  def request_clue
    threshold = 10;
    respond_to do |format|
      user = User.find_by_id( get_user_id_from_security_token ( params[:security_token] ) )  
    
      if user
        game = user.games.find_by_id( params[:game_id] )
        
        
        
        if game
          inputs = ActiveSupport::JSON.decode(params[:input_coordinates])
          match_location = 0;

          game.locations.all.each do |l|
            match_coordinate = 0

            l.point_coordinates.each do |p|
            
              inputs.each do |i|
                if (i["MAC"] == p[:MAC] && (i["signal_str"] - p[:signal_str]).abs <= threshold)
                  match_coordinate += 1
                end
              end
            end
            
            if match_coordinate == l.point_coordinates.size #or greater than some threshold to allow more flexibility
              match_location += 1
              format.html { render :text => "Location matches with " + l.location_info }
            end
            
          end
          
          if match_location == 0
            format.html { render :text => "This is not the correct location" }
          end
          
        else
          format.html { render :text => "Error: The user doesn't play this game" }
        end
        
      else
        format.html { render :text => "Error: User not found" }
      end
      
    end
    
  end

  def clear_location
    user = User.find_by_id( get_user_id_from_security_token (params[:security_token]) )
    if user
        loc = Location.find_by_id(params[:location_id])
        if loc
            rel = UserLocationRelation.new
            rel.user = user
            rel.location = loc
        else
            format.html { render :text => "Error: Invalid location id", :status => 400}
        end        
    else
        format.html { render :text => "Error: Invalid security token", :status => 401}
    end
  end
end
