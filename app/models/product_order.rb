class ProductOrder < ActiveRecord::Base
  attr_accessible :product, :quantity
end
