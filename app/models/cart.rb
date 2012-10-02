class Cart < ActiveRecord::Base
  attr_accessible :id, :user_id
  
  validates :id, :presence => true
  validates :user_id, :presence => true
  validates :user_id, :uniqueness => true
  
  def add(prod_ord)
    prod_ord.add_to_cart(self.id)
  end

  def remove(prod_ord)
    prod_ord.remove_from_cart
  end

  def checkout
    ## Logic could go here with logging or whatever.
    ProductOrder.find(:cart_id => self.id).destroy
  end

  def clear
    ProductOrder.find(:cart_id => self.id).destroy
  end

  def assign(user)
    self.user_id = user
    self.save
  end
end
