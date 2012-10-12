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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def test_change_password
    u = users(:user17)
    
    u.changePassword "17"
    p = BCrypt::Password.new(u.password_digest)
    assert (p == "17")
    
    ## Shouldn't accept nil.
    u.changePassword nil
    p = BCrypt::Password.new(u.password_digest)
    assert (p == "17")
  end
end
