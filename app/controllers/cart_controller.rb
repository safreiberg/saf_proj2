class CartController < ApplicationController
  protect_from_forgery
  
  before_filter :checkAuth
  before_filter :check_cart
  
  def view
    ## This is the "adding orders" part.
    prod_ord = nil
    if params[:quantity] && params[:product_id]
      if prod_ord = ProductOrder.where(:cart_id => session[:cart].id, :product_id => params[:product_id]).first
        prod_ord.change_quantity(prod_ord.quantity.to_i + params[:quantity].to_i)
      else
        prod_ord = ProductOrder.create(:cart_id => session[:cart].id, :quantity => params[:quantity], :product_id => params[:product_id])
      end
      if prod_ord.quantity > Product.find_by_id(prod_ord.product_id).inventory
        prod_ord.change_quantity(Product.find_by_id(prod_ord.product_id).inventory)
        flash[:notice] = "You attempted to purchase more than the inventory, so we decreased your order to the max."
      end
      if prod_ord.quantity < 0
        prod_ord.change_quantity(1)
        flash[:notice] = "You must buy at least one! Silly goose."
      end
    end
    ## This is the update part
    if params[:update] == "true"
      logger.debug("Updating ProductOrder.")
      params.each do |key, value| 
        if (key.to_s[/.*quantity/])
          po = ProductOrder.where(:product_id => key.to_s.chomp(".quantity"), :cart_id => session[:cart].id).first
          if value.to_i > Product.find_by_id(po.product_id).inventory.to_i
            value = Product.find_by_id(po.product_id).inventory.to_i
            flash[:notice] = "You attempted to purchase more than the inventory, so we decreased your order to the max."
          end
          if value.to_i < 0
            value = 1
            flash[:notice] = "You must buy at least one! Silly goose."
          end
          po.change_quantity(value)
        end
      end
    end
  end

  def checkout
    ## Here's where we add stuff to the orders page.
    ProductOrder.where(:cart_id => session[:cart].id).each do |po|
      @prod = Product.where(:id => po.product_id).first
      logger.debug("Inspecting product order: " + po.id.to_s)
      if po != nil && @prod != nil
        logger.debug("Creating Order.")
        @price = @prod.price.to_f * po.quantity.to_f
        o = Order.create(:user_id => session[:cart].user_id, :product_id => po.product_id, :product_quantity => po.quantity, :price => @price)
      end
    end
    user = User.find_by_id(session[:user_id])
    if !user.nil? && user.email
      SafMailer.checkout(user).deliver
    end
    session[:cart].checkout
  end
  
  def specs
  end
  
end
