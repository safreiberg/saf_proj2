# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  inventory   :integer
#  price       :float
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  def test_update_inventory
    p = products(:product_one)
    assert_equal 17, p.inventory.to_i, "initial inventory is 17"
    p.update_inventory 25
    assert_equal 25, p.inventory.to_i, "inventory changed to 25"
    assert_equal 1, p.id, "ID should never change"
  end
  
  def update_price
    p = products(:product_one)
    assert_equal 15, p.price.to_f, "initial price is 15"
    p.update_price 25.241
    assert_equal 25.241, p.inventory.to_f, "price changed to 25.241"
    assert_equal 1, p.id, "ID should never change"
  end
  
  def update_name
    p = products(:product_one)
    assert_equal "Item One", p.name.to_s, "initial name is 'Item One'"
    p.update_name "Jargon"
    assert_equal "Jargon", p.name.to_s, "name changed to Jargon"
    assert_equal 1, p.id, "ID should never change"    
  end
  
  def update_description
    p = products(:product_one)
    assert_equal "The first product", p.description.to_s, "initial description is 'The first product'"
    p.update_description "Jargon"
    assert_equal "Jargon", p.description.to_s, "description changed to Jargon"
    assert_equal 1, p.id, "ID should never change"    
  end
end
