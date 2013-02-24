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
	user = User.new(:name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password])
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
                format.html { render :text => "Error: Invalid game id", :status => 401}
            end
        else
            format.html { render :text => "Error: Invalid security token", :status => 401}
        end
    end
  end

  def request_clue
  
  end

  def clear_location
    user = User.find_by_id( get_user_id_from_security_token (params[:security_token]) )
    if user
        
    else
    end
  end
end
