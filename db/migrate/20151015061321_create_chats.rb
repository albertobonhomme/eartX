class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
    	t.references :product, index: true
    	t.string :buyer_new
     	t.string :seller_new
      t.timestamps null: false
    end
    
    add_reference :chats, :buyer, references: :users
    add_reference :chats, :seller, references: :users
  end
end
