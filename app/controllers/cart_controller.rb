class CartController < ApplicationController
  protect_from_forgery
  
  before_filter :checkAuth
  before_filter :check_cart
  
  def view
    if params[:quantity] && params[:product_id]
      if prod_ord = ProductOrder.where(:cart_id => session[:cart], :product_id => params[:product_id]).first
        prod_ord.change_quantity(prod_ord.quantity.to_i + params[:quantity].to_i)
      else
        prod_ord = ProductOrder.create(:cart_id => session[:cart], :quantity => params[:quantity], :product_id => params[:product_id])
        session[:cart].add(prod_ord)
      end
    end
  end

  def checkout
  end
  
  def specs
  end
  
end
