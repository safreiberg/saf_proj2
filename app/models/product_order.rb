class ProductOrder < ActiveRecord::Base
  attr_accessible :product_id, :quantity, :cart_id
  
  validates :product_id, :presence => true
  validates :quantity, :presence => true
  validates :cart_id, :presence => true
  
  def add_to_cart(new_cart_id)
    self.cart_id = new_cart_id
    self.save
  end
  
  def remove_from_cart
    self.cart_id = 0
    self.save
    self.destroy
  end
  
  def change_quantity(quant)
    self.quantity = quant
    self.save
  end
end
