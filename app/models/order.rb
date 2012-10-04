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

class Order < ActiveRecord::Base
  attr_accessible :product_id, :product_quantity, :user_id, :price
end
