class WelcomesController < ApplicationController
  skip_before_action :authenticate_user

  def index
    if session[:user_id] != nil
      redirect_to events_path
    end
  end
end
