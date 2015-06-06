module ApplicationHelper
  
  def load_nav_bar
    if session[:user_id] != nil
      render :partial => 'shared/usernav'
    else 
      render :partial => 'shared/nav' 
    end
  end
  
  def load_flash_loginfail
    if flash[:login_fail]
      render :partial => 'shared/loginfail'
    end
  end

end
