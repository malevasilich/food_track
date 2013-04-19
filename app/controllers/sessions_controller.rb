# encoding: utf-8
class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create  
    user = User.find_by_name(params[:name])
  	if user and user.authenticate(params[:password])
      session[:user_id] = user.id 
      response.headers['X-CSRF-Token'] = form_authenticity_token 
      redirect_to food_tracks_path
    else  
      render "new", notice:  "Не получилось" 
    end  
  end  

  def delete
    session[:user_id] = nil
    redirect_to login_url
  end
end
