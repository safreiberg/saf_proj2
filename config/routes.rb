SafProj2::Application.routes.draw do
  
  get "/wishlists/view" => "wish_lists#view"
  post "/wishlists/view" => "wish_lists#view"
  get "/wishlists/new" => "wish_lists#new"
  post "/wishlists/new" => "wish_lists#new"
  post "/wishlists/create" => "wish_lists#create"
  get "/wishlists/zoom/:id" => "wish_lists#zoom"
  post "/wishlists/zoom/:id" => "wish_lists#zoom"
  post "/wishlists/delete/" => "wish_lists#delete"
  post "/wishlists/additem" => "wish_lists#additem"
  post "/wishlists/delete_list" => "wish_lists#delete_list"
  post "/wishlists/email/" => "wish_lists#email"
  
  get "/admin/orders" => "admin#orders"
  get "/admin/items" => "admin#items"
  post "/admin/items" => "admin#items"
  post "/admin/delete" => "admin#delete"
  get "/users/edit" => "users#edit"
  post "/users/edit" => "users#edit"
  get "/users/change" => "users#change"
  post "/users/change" => "users#change"

  resources :users
  
  get "/user/create" => "users#create"
  post "/user/create" => "users#create"

  get "/cart/view/" => "cart#view"
  post "/cart/view/" => "cart#view"

  get "/cart/checkout/:userid" => "cart#checkout"
  get "/cart/checkout/" => "cart#checkout"
  post "/cart/checkout" => "cart#checkout"
  
  get "/item/list/" => "item#list"
  get "/item/zoom/:id" => "item#zoom"
  
  match "/sessions/create" => "sessions#create"
  
  match "/login" => "sessions#new"
  match "/signup" => "users#new"
  match "/logout" => "sessions#destroy"

  root :to => "welcome#index"
  match "*path" => "welcome#index"
end
