# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  product_id       :integer
#  product_quantity :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  price            :float
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
