# == Schema Information
#
# Table name: wish_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  priv       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WishList < ActiveRecord::Base
  attr_accessible :name, :priv, :user_id
  
  validates_presence_of :name
  validates_presence_of :user_id
  
end
