class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :side
    	t.float :price
    	t.references :artwork, index: true
    	t.references :user, index: true
    	t.datetime :expiration_date
    	t.integer :shares
      t.string :status
      t.float :execution_price
      

      t.timestamps null: false
    end
  end
end
