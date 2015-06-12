module ApplicationHelper
  
  def load_nav_bar
    if session[:user_id] != nil
      render :partial => 'shared/usernav'
    else 
      render :partial => 'shared/nav' 
    end
  end
  
  def load_flash(msg)
    if flash[msg]
      render :partial => 'shared/' + msg
    end
  end

end
