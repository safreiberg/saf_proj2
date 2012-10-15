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
    get "/item/list"
    assert_response :success
    
    ## View Product 1
    get "/item/zoom/1"
    assert_response :success
    
    ## Add 5 of them to the cart
    post_via_redirect "/cart/view", { :quantity => 5, :product_id => 1 }
    assert_equal "/cart/view", path
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    assert_equal 5, ProductOrder.where(:cart_id => session[:cart].id).first.quantity
    assert_equal 1, ProductOrder.where(:cart_id => session[:cart].id).first.product_id
    
    ## Checkout
    get "/cart/checkout"
    assert_response :success
    assert_equal 0, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    
    ## Logout
    get "/logout"
    assert_response :redirect
    follow_redirect!
    assert_not_equal 1, session[:user_id]
    assert_not_equal true, session[:authenticated]
    assert_not_nil session[:cart]
  end
  
  def test_no_login_purchase
    ## Welcome#index
    get "/"
    assert_response :success
    assert_not_nil session[:cart]
    assert_not_nil session[:user_id]
    assert_not_equal true, session[:authenticated], "session should not indicate authenticated user."
    
    ## Item list
    get "/item/list"
    assert_response :success
    
    ## Zoom item 2
    get "/item/zoom/2"
    assert_response :success
    
    ## Add 4 of them to the cart
    post_via_redirect "/cart/view", {:quantity => 4, :product_id => 2}
    assert_equal "/cart/view", path
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    ## Inventory limit...
    assert_equal 1, ProductOrder.where(:cart_id => session[:cart].id).first.quantity
    assert_equal 2, ProductOrder.where(:cart_id => session[:cart].id).first.product_id
    
    ## Back to list
    get "/item/list"
    assert_response :success
    
    ## Zoom item 1
    get "/item/zoom/1"
    assert_response :success
    
    ## Add 7 to the cart
    post_via_redirect "/cart/view", {:quantity => 4, :product_id => 1}
    assert_equal "/cart/view", path
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    
    ## Back to list
    get "/item/list"
    assert_response :success
    
    ## Zoom item 2
    get "/item/zoom/2"
    assert_response :success
    
    ## Add 8 more to the cart
    post_via_redirect "/cart/view", {:quantity => 8, :product_id => 2}
    assert_equal "/cart/view", path
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ? AND product_id = 2", session[:cart].id ])
    ## Inventory
    assert_equal 1, ProductOrder.where(:cart_id => session[:cart].id, :product_id => 2).first.quantity
    
    ## Checkout
    get "/cart/checkout"
    assert_response :success
    assert_equal 0, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    
    ## Logout
    get "/logout"
    assert_response :redirect
    assert_not_equal true, session[:authenticated]
    assert_not_nil session[:cart]
  end
  
  def test_add_items_then_login
    ## Welcome#index
    get "/"
    assert_response :success
    assert_not_nil session[:cart]
    assert_not_nil session[:user_id]
    assert_not_equal true, session[:authenticated], "session should not indicate authenticated user."
    
    ## Item list
    get "/item/list"
    assert_response :success
    
    ## Zoom item 2
    get "/item/zoom/2"
    assert_response :success
    
    ## Add 4 of them to the cart
    post_via_redirect "/cart/view", {:quantity => 4, :product_id => 2}
    assert_equal "/cart/view", path
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    ## Should not be able to add more than the inventory.
    assert_equal 1, ProductOrder.where(:cart_id => session[:cart].id).first.quantity
    assert_not_nil flash[:notice]
    assert_equal 2, ProductOrder.where(:cart_id => session[:cart].id).first.product_id
    
    ## Sign in
    get "/login"
    assert_response :success
    
    ## Login via post
    post_via_redirect "/sessions/create", { :email => "saf", :password => "a" }
    assert_equal 1, session[:user_id]
    assert_equal true, session[:authenticated]
    assert_not_nil session[:cart]
    assert_equal '/', path
    assert_equal 'Successfully logged in.', flash[:notice]
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
        
    ## Back to list
    get "/item/list"
    assert_response :success
    
    ## Zoom item 1
    get "/item/zoom/1"
    assert_response :success
    
    ## Add 7 to the cart
    post_via_redirect "/cart/view", {:quantity => 4, :product_id => 1}
    assert_equal "/cart/view", path
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    
    ## Back to list
    get "/item/list"
    assert_response :success
    
    ## Zoom item 2
    get "/item/zoom/2"
    assert_response :success
    
    ## Add 8 more to the cart
    post_via_redirect "/cart/view", {:quantity => 8, :product_id => 2}
    assert_equal "/cart/view", path
    assert_equal 2, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    assert_equal 1, ProductOrder.count(:conditions => ["cart_id = ? AND product_id = 2", session[:cart].id ])
    ## Inventory
    assert_equal 4, ProductOrder.where(:cart_id => session[:cart].id, :product_id => 1).first.quantity
    
    ## Checkout
    get "/cart/checkout"
    assert_response :success
    assert_equal 0, ProductOrder.count(:conditions => ["cart_id = ?", session[:cart].id])
    
    ## Logout
    get "/logout"
    assert_response :redirect
    assert_not_equal 1, session[:user_id]
    assert_not_equal true, session[:authenticated]
    assert_not_nil session[:cart]
  end
  
  def test_no_admin_access
    get "/"
    assert_response :success
    
    ## Try admin pages
    get "/admin/items"
    assert_response :redirect
    follow_redirect!
    assert_equal "/welcome", path
      
    get "/admin/orders"
    assert_response :redirect
    follow_redirect!
    assert_equal "/welcome", path
  end
  
  def test_admin_access
    get "/"
    assert_response :success
    
    ## Login via post
    post_via_redirect "/sessions/create", { :email => "admin", :password => "admin" }
    assert_equal 2, session[:user_id]
    assert_equal true, session[:authenticated]
    assert_not_nil session[:cart]
    assert_equal '/', path
    assert_equal 'Successfully logged in.', flash[:notice]
    
    ## Try admin pages
    get "/admin/items"
    assert_response :success
      
    get "/admin/orders"
    assert_response :success
    
    get "/logout"
    assert_response :redirect
    assert_not_equal 2, session[:user_id]
    assert_not_equal true, session[:authenticated]
    assert_not_nil session[:cart]
  end
end
