class Product < ActiveRecord::Base
	belongs_to :user
	has_one :category
	has_one :condition
	has_one :gender
	has_many :comments
	has_many :chats

end
