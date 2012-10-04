class CartController < ApplicationController
  protect_from_forgery
  
  before_filter :checkAuth
  before_filter :check_cart
  
  def view
    ## This is the "adding orders" part.
    if params[:quantity] && params[:product_id]
      if prod_ord = ProductOrder.where(:cart_id => session[:cart], :product_id => params[:product_id]).first
        prod_ord.change_quantity(prod_ord.quantity.to_i + params[:quantity].to_i)
      else
        prod_ord = ProductOrder.create(:cart_id => session[:cart], :quantity => params[:product_id], :product_id => params[:product_id])
      end
    end
    ## This is the update part
    if params[:update] == "true"
      logger.debug("Updating ProductOrder.")
      params.each do |key, value| 
        if (key.to_s[/.*quantity/])
          po = ProductOrder.where(:product_id => key.to_s.chomp(".quantity"), :cart_id => session[:cart].id).first
          po.change_quantity(value)
        end
      end
    end
  end

  def checkout
  end
  
  def specs
  end
  
end
