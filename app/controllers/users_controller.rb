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
      flash[:notice] = "Your account has been created."
      render '/welcome/index'
      return
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
        flash[:notice] = "You already had an account. We went ahead and signed you in :)."
        render '/welcome/index'
        return
      elseif user
        ##    Case 2.
        logger.debug("Signin failed.")
        if @user = User.where(:email => params[:user][:email]).first
          flash[:notice] = "That user already exists."
          render '/users/new'
          return
        end
      else
        flash[:notice] = "Password confirmation was incorrect."
        logger.debug("Couldn't even log them in.")
        render '/users/new'
        return
      end
    end
  end


end
