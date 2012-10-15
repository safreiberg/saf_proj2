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
      ## Now we have to add any new items that were written in.
      if params[:added] != 0
        for i in 1..params[:added].to_i
          @n = "name.new." + i.to_s
          @p = "price.new." + i.to_s
          @inv = "inventory.new." + i.to_s
          @des = "description.new." + i.to_s
          if params[@n] && params[@p] && params[@inv] && params[@des]
            Product.create(:name => params[@n].to_s, :price => params[@p].to_f, :inventory => params[@inv].to_i, :description => params[@des].to_s)
          end
        end
      end
    end
  end
  
  def delete 
    logger.debug("Delete item: " + params[:prod_id].to_s)
    p = Product.where(:id => params[:prod_id]).first
    if p != nil
      ProductOrder.where(:product_id => p.id).each do |po| po.destroy end
      p.delete
    end
    redirect_to "/admin/items" and return
  end
end
