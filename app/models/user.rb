class User < ActiveRecord::Base
  attr_accessible :email, :id, :name, :password, :password_confirmation
  :has_secure_password
  
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :name, :presence => true
  validates :id, :presence => true
  validates :password, :presence => true, :on => :create
end
