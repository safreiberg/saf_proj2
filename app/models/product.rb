class Product < ActiveRecord::Base
  attr_accessible :inventory, :price, :id, :name, :description
  
  validates :inventory, :presence => true
  validates :price, :presence => true
  validates :id, :presence => true
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
