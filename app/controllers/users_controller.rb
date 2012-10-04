class UsersController < ApplicationController

  after_filter :check_cart
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    logger.debug("Just attempted to create a user.")
    if @user.save
      logger.debug("Your account has been created")
      session[:user_id] = @user.id
      stuff_in_cart
      flash[:notice] = "Your account has been created."
      session[:authenticated] = true
      render '/welcome/index' and return
    else
      ## Let's attempt to log the user in, since they weren't able to create an account.
      ## This means that either 
      ##    (1) Account already claimed, and entered the right password
      ##    (2) Account already claimed, and entered the wrong password
      ##    (3) Account not claimed, and entered two different passwords
      logger.debug("Failure :( to create new account.")
      logger.debug(params[:user][:email].to_s)
      user = User.find_by_email(params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        ##    This is case 1.
        session[:user_id] = user.id
        stuff_in_cart
        flash[:notice] = "You already had an account. We went ahead and signed you in :)."
        session[:authenticated] = true
        redirect_to '/welcome/index' and return
      elseif user
        ##    Case 2.
        logger.debug("Signin failed.")
        if @user = User.where(:email => params[:user][:email]).first
          flash[:notice] = "That user already exists."
          session[:authenticated] = false
          render '/users/new' and return
        end
      else
        flash[:notice] = "Password confirmation was incorrect."
        session[:authenticated] = false
        logger.debug("Couldn't even log them in.")
        render '/users/new' and return
      end
    end
  end
  
  def stuff_in_cart
    @cart = Cart.where(:user_id => session[:user_id]).first
      if @cart == nil
        redirect_to root_url, :notice => "Successfully logged in."
        return
      else
        ProductOrder.where(:cart_id => session[:cart].id).each do |po| 
          po.add_to_cart(@cart.id) 
          po.save
        end
      end
      session[:cart] = @cart
  end

end
