class ApplicationController < ActionController::Base
  protect_from_forgery


  def current_user
    @_current_user ||= session[:current_user] && User.find_by_id(session[:current_user])
  end
  
  def checkAuth
    if !session[:current_user]
      session[:current_user] = request.remote_ip
    end
    logger.debug("Current user: " + session[:current_user].to_s)
  end

end
