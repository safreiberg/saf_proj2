require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  ## Tests a proper, non-admin login.
  def test_login_normal_user
    post :create, :email => "saf", :password => "a" 
    
    assert_response :redirect
    assert_not_nil session[:user_id], "Session[user_id] was nil after login."
    assert_equal 1, session[:user_id], "Session[user_id] should be 1 for saf."
    assert_not_nil session[:cart], "After login, a cart should be established."
    assert_redirected_to root_url, "Correct login will redirect to root_url."
    assert_equal true, session[:authenticated], "After login, session should indicate an authenticated user."
  end
  
  ## Tests an admin login. This should not be different from above.
  def test_login_admin
    post :create, :email => "admin", :password => "admin" 
    
    assert_response :redirect
    assert_not_nil session[:user_id], "Session[user_id] was nil after login."
    assert_not_nil session[:cart], "After login, a cart should be established."
    assert_equal 2, session[:user_id], "Session[user_id] should be 2 for admin."
    assert_redirected_to root_url, "Correct login will redirect to root_url."
    assert_equal true, session[:authenticated], "After login, session should indicate an authenticated user."
  end
  
  ## Tests an incorrect login. 
  def test_login_badpass
    post :create, :email => "saf", :password => "wrong" 
    
    assert_response :success
    assert_not_equal 1, session[:user_id], "Session[user_id] should not be 1 for incorrect password for saf."
    assert_not_nil session[:cart], "After unsuccessful login, a cart should be established."
  end
  
  ## Tests login then logout
  def test_login_logout
    ## login
    post :create, :email => "saf", :password => "a" 
    
    ## logout
    get :destroy
    
    assert_response :redirect, "Logout should redirect."
    assert_redirected_to "/?notice=Logged+out", "After logout, should redirect to root_url with logout notice."
    assert_not_equal 1, session[:user_id], "Logout should change the session[:user_id] from 1 for saf."
    assert_not_nil session[:cart], "After login, a cart should be established."
    assert_equal false, session[:authenticated], "Logout should make session[:authenticated] false."
  end
  
end
