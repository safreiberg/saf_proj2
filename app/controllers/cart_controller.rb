class CartController < ApplicationController
  protect_from_forgery
  
  before_filter :checkAuth
  
  def view
  end

  def checkout
  end
  
  def specs
  end

end