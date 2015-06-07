class WelcomesController < ApplicationController
  def index
    if session[:user_id] != nil
      #no need to use render :partial here Why??
      render 'user_index' 
    end
  end
end
