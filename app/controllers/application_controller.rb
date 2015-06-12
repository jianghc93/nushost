class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session
  before_action :authenticate_user
  
  #methods defined here are available across all controllers, but not in views. For views use the helper 
  def current_user
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    end
  end

  private
  def authenticate_user
    if session[:user_id]
      #do nothing
    else
      flash[:auth_fail] = "Please login to access the page ^.^"
      redirect_to root_url
    end
  end

  #allows @current_user to be accessed in views
  helper_method :current_user
end
