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
