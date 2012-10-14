# == Schema Information
#
# Table name: product_orders
#
#  id         :integer          not null, primary key
#  product_id :integer
#  quantity   :integer
#  cart_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductOrder < ActiveRecord::Base
  attr_accessible :product_id, :quantity, :cart_id
  
  validates :product_id, :presence => true
  validates :quantity, :presence => true
  validates :cart_id, :presence => true
  validates :quantity, :length => { :minimum => 0 }
  
  def add_to_cart(new_cart_id)
    po = ProductOrder.where(:product_id => self.product_id, :cart_id => new_cart_id).where('product_orders.id != ?',self.id).first
    if po == nil
      if self.quantity == 0
        self.destroy
      else
        self.cart_id = new_cart_id
        self.save
      end
    else
      po.change_quantity(po.quantity + self.quantity)
      self.destroy
    end
  end
  
  def remove_from_cart
    self.cart_id = 0
    self.save
    self.destroy
  end
  
  def change_quantity(quant)
    if quant > Product.find_by_id(self.product_id).inventory
      quant = Product.find_by_id(self.product_id).inventory
      flash[:notice] = "You attempted to purchase more than the inventory, so we decreased your order to the max."
    end
    if quant < 0
      prod_ord.quantity = 1
      flash[:notice] = "You must buy at least one! Silly goose."
    end
    self.quantity = quant
    self.save
    if self.quantity == 0
      self.destroy
    end
  end
end
