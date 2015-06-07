class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session
  
  #methods defined here are available across all controllers, but not in views. For views use the helper 
  def set_current_user(user)
    @current_user = "test123"
  end
  
  def current_user
    @current_user 
  end
  
  #allows @current_user to be accessed in views
  helper_method :current_user
end
