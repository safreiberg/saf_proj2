class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    logger.debug("Just attempted to create a user.")
    if @user.save
      logger.debug("Your account has been created")
      session[:user_id] = @user.id
    else
      ## Let's attempt to log the user in
      logger.debug("Failure :(.")
      logger.debug(params[:user][:email].to_s)
      user = User.find_by_email(params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        flash[:notice] = "You already had an account. We went ahead and signed you in :)."
        redirect_to root_url
        return
      else
        logger.debug("Signin failed.")
        if @user = User.where(:email => params[:user][:email]).first
          flash[:alert] = "That user already exists."
          render '/users/new'
          return
        end
      end
      
      if !session[:user_id].to_s.include? '.'
        logger.debug("Current user: " + session[:user_id].to_s + ", in UsersController.")
        flash[:notice] = "You already had an account. We went ahead and signed you in :)."
        render '/welcome'
        return
      else
        logger.debug("Couldn't even log them in.")
        render '/users/new'
        return
      end
    end
  end


end
