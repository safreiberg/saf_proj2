class CreateProductOrders < ActiveRecord::Migration
  def change
    create_table :product_orders do |t|
      t.integer :product_id, :limit => 8
      t.integer :quantity, :limit => 8
      t.integer :id, :limit => 8
      t.integer :cart_id, :limit => 8

      t.timestamps
    end
  end
end
