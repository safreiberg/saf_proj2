require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get orders" do
    get :orders
    assert_response :success
  end

  test "should get items" do
    get :items
    assert_response :success
  end

end
