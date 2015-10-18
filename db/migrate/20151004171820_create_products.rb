class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.references :user, index: true
    	t.integer :price
    	t.string :name
    	t.string :brand
    	t.string :description
    	t.string :image
      t.string :size
      t.references :condition, index: true
      t.references :gender, index: true
      t.string :vendido, :default => "No"
    	t.references :category, index:true

      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
