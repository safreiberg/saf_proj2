require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    
    assert_response :success
    assert_not_nil session[:user_id], "Session[user_id] was nil."
    assert_not_nil session[:cart], "Session[cart] was nil."
    assert_not_equal true, session[:authenticated], "No user has been authenticated."
  end
end
