require 'zlib'

class ApplicationController < ActionController::Base
  protect_from_forgery


  def current_user
    @_current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
  end
  
  def checkAuth
    if !session[:user_id]
      session[:user_id] = Zlib.crc32(request.remote_ip)
    end
    logger.debug("Current user: " + session[:user_id].to_s)
  end
  
  def check_cart
    if !session[:cart] || session[:cart] == nil || session[:cart].user_id != session[:user_id]
      @cart = Cart.where(:user_id => session[:user_id]).first
      if @cart == nil
        @cart = Cart.new(:user_id => session[:user_id])
        @cart.save
      end
      session[:cart] = @cart
    end
    logger.debug("Current cart: " + session[:cart].id.to_s)
  end

end
