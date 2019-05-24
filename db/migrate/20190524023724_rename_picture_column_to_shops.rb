class RenamePictureColumnToShops < ActiveRecord::Migration[5.2]
  def change
    rename_column :shops, :picture, :image
  end
end
