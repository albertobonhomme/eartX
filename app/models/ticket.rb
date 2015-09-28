class Ticket < ActiveRecord::Base
	belongs_to :artwork
	belongs_to :buyer_id,  class_name: "User"
	belongs_to :seller_id,  class_name: "User"

end
