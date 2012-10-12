require 'test_helper'

class LoginsTest < ActionDispatch::IntegrationTest
  def test_login_simple
    ## Go to login page
    get "/login"
    assert_response :success
    
    ## Login via post
    post_via_redirect "/sessions/create", { :email => "saf", :password => "a" }
    assert_equal 1, session[:user_id]
    assert_equal true, session[:authenticated]
    assert_not_nil session[:cart]
    assert_equal '/', path
    assert_equal 'Successfully logged in.', flash[:notice]
    
    ## Go to items list
    get "item/list"
    assert_response :success
    
    ## View Product 1
    get "item/zoom/1"
    assert_response :success
    
    ## Add 5 of them to the cart
    post_via_redirect "/cart/view", { :quantity => 5, :product_id => 1 }
    assert_equal "/cart/view", path
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    assert_equal 5, ProductOrder.where(:cart_id => session[:cart].id).first.quantity
    assert_equal 1, ProductOrder.where(:cart_id => session[:cart].id).first.product_id
  end
end
