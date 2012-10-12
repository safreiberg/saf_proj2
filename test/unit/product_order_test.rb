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

require 'test_helper'

class ProductOrderTest < ActiveSupport::TestCase
  
  def test_add_to_cart
    cart = carts(:one)
    ## With cart empty
    po = ProductOrder.create(:product_id => 1, :cart_id => cart.id, :quantity => 3)
    po.add_to_cart(cart.id)
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", cart.id])
    
    ## With something in cart
    po = ProductOrder.create(:product_id => 2, :cart_id => cart.id, :quantity => 7)
    po.add_to_cart(cart.id)
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", cart.id])
    
    ## With some product in cart
    po = ProductOrder.create(:product_id => 1, :cart_id => cart.id, :quantity => 3)
    po.add_to_cart(cart.id)
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", cart.id])

    ## With quantity zero.
    po = ProductOrder.create(:product_id => 3, :cart_id => cart.id, :quantity => 0)
    po.add_to_cart cart.id
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", cart.id])
  end
  
  def test_remove_from_cart
    cart = carts(:one)
    ## Removing to make the cart empty
    po = ProductOrder.create(:product_id => 1, :cart_id => cart.id, :quantity => 3)
    po.add_to_cart(cart.id)
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", cart.id])
    po.remove_from_cart
    
    ## To make cart unempty
    po = ProductOrder.create(:product_id => 2, :cart_id => cart.id, :quantity => 7)
    po.add_to_cart(cart.id)
    po = ProductOrder.create(:product_id => 1, :cart_id => cart.id, :quantity => 3)
    po.add_to_cart(cart.id)
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", cart.id])
    po.remove_from_cart
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", cart.id])
    
    ## When the cart is nil
    po = ProductOrder.create(:product_id => 2, :quantity => 7)
    po_id = po.id
    po.remove_from_cart
    assert_nil ProductOrder.find_by_id(po_id)
  end

  def test_change_quantity
    po = ProductOrder.create(:product_id => 1, :cart_id => 1, :quantity => 3)
    po_id = po.id
    
    po.change_quantity 15
    assert_equal 15, ProductOrder.find_by_id(po_id).quantity
    
    po.change_quantity 0
    assert_nil ProductOrder.find_by_id po_id
  end
  
end
