class SessionsController < ApplicationController
  def new
    create
  end
   
  def create
    authenticate_with_open_id("http://openid.nus.edu.sg",
                              :required => [:fullname],
                              :optional => :email) do |result, identity_url, registration|
      if result.successful?
        # FIXME - needs normalizing before
        #OpenIdAuthentication.normalize_url(identity_url)
        # checking for the identity_url
          user = User.find_by_identity_url(identity_url)
          if user == nil 
            puts registration['fullname']
            puts identity_url
            user = User.new
            user.identity_url = identity_url
            user.save
            #user.name = registration['fullname']
            #puts user.name
            #user.identity_url = identity_url
            #user.save()
          end
          sign_in user
      else
        render 'new'
        end
      end
  end
 
  def destroy
    # contains the logic for destroying the user
    # session (logout)
  end
  
  def sign_in(user)
    session[:user_id] = user.id
    redirect_to(root_url)
  end

end
