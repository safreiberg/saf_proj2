SafProj2::Application.routes.draw do
  
  get "admin/orders"

  get "admin/items" => "admin#items"
  post "admin/items" => "admin#items"

  resources :users
  
  get "user/create" => "users#create"
  post "user/create" => "users#create"

  get "cart/view/" => "cart#view"
  post "cart/view/" => "cart#view"

  get "cart/checkout/:userid" => "cart#checkout"
  get "cart/checkout/" => "cart#checkout"
  
  get "item/list/" => "item#list"
  get "item/zoom/:id" => "item#zoom"
  
  match "sessions/create" => "sessions#create"
  
  match "login" => "sessions#new"
  match "signup" => "users#new"
  match "logout" => "sessions#destroy"

  root :to => "welcome#index"
  match "*path" => "welcome#index"
end
