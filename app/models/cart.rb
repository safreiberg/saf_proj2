# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ActiveRecord::Base
  attr_accessible :user_id
  
  validates :user_id, :presence => true
  
  def add(prod_ord)
    prod_ord.add_to_cart(self.id)
  end

  def remove(prod_ord)
    prod_ord.remove_from_cart
  end

  def checkout
    ## Logic could go here with logging or whatever.
    ProductOrder.where(:cart_id => self.id).each do |po|
      po.destroy
    end
  end

  def clear
    ProductOrder.find(:cart_id => self.id).destroy
  end

  def assign(user)
    self.user_id = user
    self.save
  end
end
