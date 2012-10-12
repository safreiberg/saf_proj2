require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  ## Test user creation correct.
  def test_user_creation_correct
    post :create, :user => {:email => "new_user", :password => "a", :password_confirmation => "a"}
    
    assert_response :success
    assert_not_nil session[:user_id], "Session[user_id] was nil after login."
    assert_not_nil session[:cart], "After login, a cart should be established."
    assert_equal true, session[:authenticated], "After login, session should indicate an authenticated user."
  end
  
  def test_user_creation_bad_confirmation
    post :create, :user => {:email => "new_user", :password => "a", :password_confirmation => "wrong"}
    
    assert_response :redirect
    assert_not_nil session[:user_id], "Session[user_id] should never be nil."
    assert_not_nil session[:cart], "session[:cart] should never be nil."
    assert_redirected_to "/users/new", "Correct login will redirect to root_url."
    assert_equal false, session[:authenticated], "After login, session should indicate an authenticated user."
  end
  
  def test_user_creation_already_existing
    post :create, :user => {:email => "saf", :password => "a", :password_confirmation => "a"}
    
    assert_response :redirect
    assert_redirected_to root_url
    assert_equal 1, session[:user_id], "saf has a user_id of 1"
    assert_not_nil session[:cart], "session[:cart] should never be nil."
    assert_equal true, session[:authenticated], "After login, session should indicate an authenticated user."
  end
  
  ## This should be exactly the same as test_user_creation_already_existing.
  ## The password confirmation doesn't matter for an already existing user
  ##   if the password was entered correctly.
  def test_user_creation_already_existing_wrong_confirmation
    post :create, :user => {:email => "saf", :password => "a", :password_confirmation => "wrong"}
    
    assert_response :redirect
    assert_redirected_to root_url
    assert_equal 1, session[:user_id], "saf has a user_id of 1"
    assert_not_nil session[:cart], "session[:cart] should never be nil."
    assert_equal true, session[:authenticated], "After login, session should indicate an authenticated user."
  end
end
