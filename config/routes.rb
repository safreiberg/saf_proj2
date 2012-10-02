SafProj2::Application.routes.draw do
  get "cart/view/:userid" => "cart#view"
  get "cart/view/" => "cart#view"

  get "cart/checkout/:userid" => "cart#checkout"
  get "cart/checkout/" => "cart#checkout"

  root :to => "welcome#index"
  match "*path" => "welcome#index"
end
