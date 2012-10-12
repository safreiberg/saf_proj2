class SessionsController < ApplicationController
  after_filter :checkAuth
  after_filter :check_cart

  def new
  end
  
  ##  This gets called on user signin.
  ##  Here's an option. What if someone is browing the site, adds some shit to his cart, then
  ##    realizes that he has an account. So he signs in, and there's existing stuff in his cart.
  ##    Now what? 
  ##    Our solution is to combine the two carts and let him deal with the conflict. This seems
  ##    better than the alternatives of (1) blow away the older cart, or (2) blow away the new
  ##    cart.
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      ##  Time to check if there's a cart.
      @cart = Cart.where(:user_id => session[:user_id]).first
      if @cart == nil || session[:cart].nil?
        session[:authenticated] = true
        redirect_to root_url, :notice => "Successfully logged in."
        return
      else
        ProductOrder.where(:cart_id => session[:cart].id).each do |po| 
          po.add_to_cart(@cart.id) 
          po.save
        end
      end
      session[:cart] = @cart
      session[:authenticated] = true
      redirect_to root_url, :notice => "Successfully logged in."
      return
    else
      logger.debug("Signin failed.")
      flash.now.alert = "Invalid email or password"
      render 'new'
    end
    logger.debug("Current user: " + session[:user_id].to_s + ", in SessionsController.")
  end
  
  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    session[:authenticated] = false
    redirect_to root_url :notice => "Logged out"
  end

end
