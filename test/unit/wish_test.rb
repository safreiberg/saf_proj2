require 'test_helper'

class WishTest < ActiveSupport::TestCase
  
  def test_delete
    w = Wish.create(:product_id => 2, :wish_list_id => 1)
    w.delete
    assert_nil Wish.find_by_id(w.id)
  end
  
  def test_add
    w = Wish.create(:product_id => 2, :wish_list_id => 1)
    assert_equal 1, Wish.find_by_id(w.id).wish_list_id
    w.add_to_wish_list 5
    assert_equal 5, Wish.find_by_id(w.id).wish_list_id
  end
end
