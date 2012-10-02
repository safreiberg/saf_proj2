require 'test_helper'

class ItemControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get zoom" do
    get :zoom
    assert_response :success
  end

end
