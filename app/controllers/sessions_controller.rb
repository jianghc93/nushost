class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def login
    authenticate_with_open_id("http://openid.nus.edu.sg",
                              :required => [:fullname, :nickname, :email]) do |result, identity_url, registration|
      if result.successful?
        user = User.find_by(nickname: registration['nickname'])
        if user == nil
          user = User.create(name: registration['fullname'], nickname: registration['nickname'], email: registration['email'])
        end
        session[:user_id] = user.id
      else
        flash[:login_fail] = "You have failed to login:("
      end
      redirect_to root_url
    end
  end

  def logout
    reset_session
    redirect_to root_url
  end

end
