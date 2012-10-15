class RenameWishListPrivateToPriv < ActiveRecord::Migration
  def up
    rename_column :wish_lists, :private, :priv
  end

  def down
  end
end
