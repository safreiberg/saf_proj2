# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.create(:inventory => 100, :price => 19.95, :name => "Swiffer", :description => "Cleans the floors and shit.")
Product.create(:inventory => 4800, :price => 9.95, :name => "Trash Bin", :description => "Where you put your trash.")
Product.create(:inventory => 12, :price => 98.99, :name => "Expensive Wine", :description => "From the finest distilleries.")
Product.create(:inventory => 88, :price => 12.40, :name => "Red Pens", :description => "Lots of them!")
Product.create(:inventory => 53, :price => 2100, :name => "MacBook Pro", :description => "An expensive laptop.")