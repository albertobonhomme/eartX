class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
    	t.string :name
    	t.string :image_url
    	t.string :bio
    	t.string :born_in
    	t.string :died_in

      t.timestamps null: false
    end
  end
end
