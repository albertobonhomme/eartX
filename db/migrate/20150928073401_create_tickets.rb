class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.references :artwork, index: true
    	t.float :price
    	t.integer :shares
      t.timestamps null: false
    end
    add_reference :tickets, :buyer, references: :users
    add_reference :tickets, :seller, references: :users
  end
end
