module ApplicationHelper
  def load_nav_bar
    if session[:user_id] != nil
      #output the correct navigation bar
    else 
      render :partial => 'shared/nav' 
    end
  end
end
