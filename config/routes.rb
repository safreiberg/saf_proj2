SafProj2::Application.routes.draw do
  get "cart/view"

  get "cart/checkout"

  root :to => "welcome#index"
end
