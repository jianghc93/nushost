module SessionsHelper
#All the methods here can only be used by the corresponding view and NOT controllers
  
  def current_user=(user)
    @current_user = user
  end
 
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
   
  def signed_in?
    !current_user.nil?
  end
   
  def logout
    self.current_user= nil
    delete.cookies[:remember_token]
  end
end
