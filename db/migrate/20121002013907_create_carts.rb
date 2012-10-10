class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id, :limit => 8
      t.integer :id

      t.timestamps
    end
  end
end
