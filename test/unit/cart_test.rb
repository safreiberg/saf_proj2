# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # def test_the_lie
  #   assert_equal 1, 2, "hello this is fail :("
  # end
  def test_cart_creation
    ## This is the cart for user17
    cart = Cart.create(:user_id => 17)
    assert_equal cart, Cart.find_by_user_id(17)
  end
  
  def test_add_unique_product
    cart = carts(:one)
    
    prod_ord = ProductOrder.create(:product_id => products(:product_one).id, :quantity => 5, :cart_id => cart.id )
    cart.add prod_ord
    
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", cart.id]), "There should be one ProductOrder in this cart."
    
    prod_ord = ProductOrder.create(:product_id => products(:product_two).id, :quantity => 8, :cart_id => cart.id )
    cart.add prod_ord
    
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", cart.id]), "There should be two ProductOrder in this cart."    
  end
  
  def test_add_two_prod_ords_same_prod
    cart = carts(:one)
    
    prod_ord = ProductOrder.create(:product_id => products(:product_one).id, :quantity => 5, :cart_id => cart.id )
    cart.add prod_ord
    
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", cart.id]), "There should be one ProductOrder in this cart."
    
    prod_ord = ProductOrder.create(:product_id => products(:product_one).id, :quantity => 8, :cart_id => cart.id )
    cart.add prod_ord
    
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", cart.id]), "There should be one ProductOrder in this cart." 
    assert_equal 13, ProductOrder.where(:cart_id => cart.id).first.quantity.to_i, "Quantity should be 13 = 8 + 5."
    
    prod_ord = ProductOrder.create(:product_id => products(:product_two).id, :quantity => 8, :cart_id => cart.id )
    cart.add prod_ord
    
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", cart.id]), "There should be two ProductOrder in this cart." 
    assert_equal 13, ProductOrder.where(:cart_id => cart.id, :product_id => products(:product_one).id).first.quantity.to_i, "Quantity should be 13 = 8 + 5."
    assert_equal 8, ProductOrder.where(:cart_id => cart.id, :product_id => products(:product_two).id).first.quantity.to_i, "Quantity should be 13 = 8 + 5."
  end
end
