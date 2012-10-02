SafProj2::Application.routes.draw do
  
  get "user/new" => "user#new"

  get "user/create" => "user#create"
  post "user/create" => "user#create"

  get "cart/view/:userid" => "cart#view"
  get "cart/view/" => "cart#view"

  get "cart/checkout/:userid" => "cart#checkout"
  get "cart/checkout/" => "cart#checkout"
  
  get "item/list/" => "item#list"
  get "item/zoom/:id" => "item#zoom"
  
  match "sessions/create" => "sessions#create"
  
  match "login" => "sessions#new"
  match "signup" => "user#new"

  root :to => "welcome#index"
  match "*path" => "welcome#index"
end
