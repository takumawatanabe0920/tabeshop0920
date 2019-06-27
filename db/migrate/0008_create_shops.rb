class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :shopname
      t.text :content
      t.string :place
      t.integer :charge
      t.string :category
      t.references :admin, index: true, null: false, foreign_key: true
      

      t.timestamps
    end
  end
end
