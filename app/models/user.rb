# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  authenticated   :boolean
#  admin           :boolean
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :authenticated, :admin
  has_secure_password

  validates :password, :presence => true, :on => :create
  validates :email, :presence => true
  validates :email, :uniqueness => true

  def changePassword(p)
    self.password = p
    self.save
  end

end
