class WishListsController < ApplicationController
  before_filter :check_cart
  before_filter :checkAuth
  
  def view
    @wishlists = WishList.where(:user_id => session[:user_id])
  end
  
  def zoom
    @id = params[:id]
    @wishes = Wish.where(:wish_list_id => @id)
  end
  
  def new
    @wishlist = WishList.new
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
end
