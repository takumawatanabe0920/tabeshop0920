class AddStarttimeToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :starttime, :string
  end
end
