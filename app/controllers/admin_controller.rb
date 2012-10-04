class AdminController < ApplicationController
  
  before_filter :check_admin
  
  def orders
  end

  ## This is where the GET request to view all items and the POST request to modify items lives.
  def items
    if params[:update] == "true"
      ## Invariant: we are about to update all of the items in the library.
      logger.debug("Updating Items.")
      Product.find(:all).each do |product|
        @name_call = product.id.to_s + ".name"
        product.update_name(params[@name_call])
        @price_call = product.id.to_s + ".price"
        product.update_price(params[@price_call])
        @inventory_call = product.id.to_s + ".inventory"
        product.update_inventory(params[@inventory_call])
        @description_call = product.id.to_s + ".description"
        product.update_description(params[@description_call])
      end
    end
  end
end
