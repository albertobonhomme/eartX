class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :side
    	t.integer :price
    	t.references :artwork, index: true
    	t.references :user, index: true
    	t.datetime :expiration_date
    	t.integer :shares
      t.string :status # limit o market o cancel

      t.timestamps null: false
    end
  end
end
