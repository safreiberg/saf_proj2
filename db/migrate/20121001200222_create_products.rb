class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :inventory
      t.float :price
      t.integer :id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
