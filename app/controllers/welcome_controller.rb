class WelcomeController < ApplicationController
  before_filter :checkAuth
  before_filter :check_cart
  
  def index
  end
end
