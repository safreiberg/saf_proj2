class WelcomeController < ApplicationController
  before_filter :checkAuth
  
  def index
  end
end
