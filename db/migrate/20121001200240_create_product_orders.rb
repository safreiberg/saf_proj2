class CreateProductOrders < ActiveRecord::Migration
  def change
    create_table :product_orders do |t|
      t.integer :product
      t.integer :quantity

      t.timestamps
    end
  end
end
