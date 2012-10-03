# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  inventory   :integer
#  price       :float
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  attr_accessible :inventory, :price, :name, :description
  
  validates :inventory, :presence => true
  validates :price, :presence => true
  validates :name, :presence => true
  validates :description, :presence => true
  
  def update_inventory(amount)    
    self.inventory = amount
    self.save
  end
  
  def update_price(cost)
    self.price = cost
    self.save
  end
end
