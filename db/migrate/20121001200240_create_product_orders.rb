class CreateProductOrders < ActiveRecord::Migration
  def change
    create_table :product_orders do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :id
      t.integer :cart_id

      t.timestamps
    end
  end
end
