require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get checkout" do
    get :checkout
    assert_response :success
  end

end
