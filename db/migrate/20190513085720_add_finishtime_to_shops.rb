class AddFinishtimeToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :finishtime, :integer
  end
end
