class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :inventory, :limit => 8
      t.float :price
      t.integer :id, :limit => 8
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
