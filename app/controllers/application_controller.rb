class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user  
  before_filter :authorize
    
private  
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end  

  def authorize
  	unless User.find_by_id(session[:user_id])
    	redirect_to login_url, notice: 'Please, log in'
    end
  end
end
