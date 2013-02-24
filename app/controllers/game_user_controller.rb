class GameUserController < ApplicationController
  def login
    user = User.find_by_email(params[:email].downcase)
    respond_to do |format|
      if user && user.authenticate(params[:password])
               format.html { render :text => user[:id].to_s()+" "+user[:password_digest] }
      else
        format.html { render :text => "Invalid email/password"}
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
  end

  def game_status
  end

  def request_clue
  end

  def clear_location
  end
end
