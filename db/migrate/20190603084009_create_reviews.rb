class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :content
      t.float :rate
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true

      t.timestamps
    end
    add_index :reviews, [:user_id, :shop_id], unique: true
  end
end
