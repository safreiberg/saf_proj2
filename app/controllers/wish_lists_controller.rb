class WishListsController < ApplicationController
  before_filter :check_cart
  before_filter :checkAuth
  
  def view
    @wishlists = WishList.where(:user_id => session[:user_id])
  end
  
  def zoom
    @id = params[:id]
    @wishes = Wish.where(:wish_list_id => @id)
    
    ## To protect privacy
    wishlist = WishList.find_by_id(@id)
    if wishlist.priv == true && wishlist.user_id != session[:user_id]
      redirect_to "/welcome"
      flash[:notice] = "You do not have permission to view that wishlist."
      return false
    end
  end
  
  def new
    @wishlist = WishList.new
  end
  
  def delete_list
    wl = WishList.find_by_id(params["wish_list_id"].to_i)
    if wl && session[:user_id] == wl.user_id
      Wish.where(:wish_list_id => wl.id).each do |w| w.destroy end
      wl.destroy
    end
    redirect_to "/wishlists/view"
    return true
  end
  
  def email
    logger.debug "emmmailll"
    wl = WishList.find_by_id(params["wl_id"].to_i)
    logger.debug "in the email method"
    if wl && !wl.priv 
      logger.debug "sending the mail"
      url = "/wishlists/zoom/" + wl.id.to_s
      user = User.find_by_id(session[:user_id])
      SafMailer.share_wl(url,params["addr"],user).deliver
    end
    url = "/wishlists/zoom/" + params["wl_id"].to_s
    flash[:notice] = "Your email has been sent!"
    redirect_to url
    return true
  end
  
  def delete 
    logger.debug "destroying that wish"
    Wish.find_by_id(params["wish"]).destroy
    redirect_to "/wishlists/zoom/" + params["wish_list_id"].to_s
    return true
  end
  
  def create
    @w = WishList.new(:priv => params["wish_list"]["priv"], :user_id => session[:user_id], :name => params["wish_list"]["name"])
    if params["wish_list"]["priv"] == "false"
      @w.priv = false
    end
    if @w.save
      flash[:notice] = "You have created a new wishlist: " + @w.name
      redirect_to "/wishlists/view"
      return true
    else
      flash[:notice] = "Something went wrong... Sorry! We've sent you back to the creation page."
      redirect_to "/wishlists/new"
      return false
    end
  end
  
  def additem
    @wish = Wish.new(:wish_list_id => params["post"]["wish_list_id"].to_i, :product_id => params["product_id"].to_i)
    @wish.save
    url = "/wishlists/zoom/" + params["post"]["wish_list_id"].to_s
    logger.debug(url)
    redirect_to url
    return true
  end
end
