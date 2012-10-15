class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.string :name
      t.integer :user_id
      t.boolean :private

      t.timestamps
    end
  end
end
