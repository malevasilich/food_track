# encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create  
    user = User.find_by_name(params[:name])
  	if user and user.authenticate(params[:password])
      session[:user_id] = user.id  
      redirect_to food_tracks_path
    else  
      flash.now.alert = "Не получилось"  
      render "new", notice:  "Не получилось" 
    end  
  end  
end
