# == Schema Information
#
# Table name: wishes
#
#  id           :integer          not null, primary key
#  product_id   :integer
#  wish_list_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Wish < ActiveRecord::Base
  attr_accessible :product_id, :wish_list_id
  
  validates_presence_of :product_id
  validates_presence_of :wish_list_id
  
  def add_to_wish_list(wish_list_id)
    self.wish_list_id = wish_list_id
    self.save
  end
  
  def delete
    self.destroy
  end
end
