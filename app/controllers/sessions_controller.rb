class SessionsController < ApplicationController

  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in"
    else
      logger.debug("Signin failed.")
      flash.now.alert = "Invalid email or password"
    end
    logger.debug("Current user: " + session[:user_id].to_s + ", in SessionsController.")
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url :notice => "Logged out"
  end

end
