class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :id
  has_secure_password

  validates :password, :presence => true, :on => :create
  validates :email, :presence => true
  validates :email, :uniqueness => true

  def changePassword(p)
    self.password = p
    self.save
  end

end