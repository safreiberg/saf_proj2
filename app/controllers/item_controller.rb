class ItemController < ApplicationController
  
  before_filter :checkAuth
  before_filter :check_cart
    
  def list
  end

  def zoom
  end
end
