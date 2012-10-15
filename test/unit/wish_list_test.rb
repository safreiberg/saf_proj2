# == Schema Information
#
# Table name: wish_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  private    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class WishListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
