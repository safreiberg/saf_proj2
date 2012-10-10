class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id, :limit => 8
      t.integer :product_id, :limit => 8
      t.integer :product_quantity, :limit => 8

      t.timestamps
    end
  end
end
