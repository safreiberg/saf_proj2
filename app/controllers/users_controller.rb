class UsersController < ApplicationController

  after_filter :check_cart
  after_filter :checkAuth
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.new
  end
  
  def change
    user = User.find_by_id(session[:user_id])
    if session[:authenticated] && user && user.authenticate(params[:user][:oldpass])
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      if user.save
        flash[:notice] = "Successfully changed password."
        logger.debug("Changed password.")
        redirect_to "/welcome/index"
        return true
      else
        logger.debug("User wouldn't save.")
        render :action => "edit"
      end
    else
      logger.debug("User couldn't authenticate.")
      redirect_to "/welcome/index"
      return false
    end
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
      SafMailer.welcome_email(@user).deliver
      redirect_to "/welcome"
      return true
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
        redirect_to :controller => "welcome", :action => "index"
        return true
      elseif user
        ##    Case 2.
        logger.debug("Signin failed.")
        if @user = User.where(:email => params[:user][:email]).first
          flash[:notice] = "That user already exists."
          session[:authenticated] = false
          render '/users/new'
          return false
        end
      else
        flash[:notice] = "Password confirmation was incorrect."
        session[:authenticated] = false
        logger.debug("Couldn't even log them in.")
        redirect_to '/users/new'
        return false
      end
    end
  end
  
  def stuff_in_cart
    @cart = Cart.where(:user_id => session[:user_id]).first
    if @cart == nil || session[:cart].nil?
    else  
      ProductOrder.where(:cart_id => session[:cart].id).each do |po| 
        po.add_to_cart(@cart.id) 
        po.save
      end
    end
    session[:cart] = @cart
  end

end
