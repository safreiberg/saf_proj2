# == Schema Information
#
# Table name: product_orders
#
#  id         :integer          not null, primary key
#  product_id :integer
#  quantity   :integer
#  cart_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProductOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
