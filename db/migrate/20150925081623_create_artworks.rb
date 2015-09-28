class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
    	t.string :name
    	t.string :description
    	t.references :author, index: true
    	t.integer :year
    	t.integer :outstanding_shares
    	t.string :image_url
      t.string :status
      t.integer :ipo_price

      t.timestamps null: false
    end
  end
end
