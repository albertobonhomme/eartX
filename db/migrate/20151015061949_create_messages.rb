class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.string :content
    	t.references :user, index: true
    	t.references :chat, index: true
    	
      t.timestamps null: false
    end
  end
end
