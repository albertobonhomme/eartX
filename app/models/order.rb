class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :artwork

	def display_price_uniq
		price.uniq!
	end

	def change_to_executed(price) 
		update(status: "Executed", execution_price: price)
	end

	def produce_ticket(waiting_order)
		
		ticket = artwork.tickets.new(price: waiting_order.price, shares: [self.shares, waiting_order.shares].min, buyer_id: self.check_whois_buying(waiting_order) , seller_id: self.check_whois_selling(waiting_order))
		ticket.save

		self.artwork.set_new_last_price(ticket.price)
	end

	def check_whois_buying(waiting_order)

		if self.side == "Buy"
			self.user_id
		else
			waiting_order.user_id
		end
	end

	def check_whois_selling(waiting_order)

		if self.side == "Sell"
			self.user_id
		else
			waiting_order.user_id
		end
	end


	def refresh_shares_to_be_executed(shares)
		self.update(shares: shares)
	end

	def read_and_match(bid, offer)

		if (self.side == "Buy") && offer.first && (self.price >= offer.first.price)
			match_with_market(offer.first)
		elsif (self.side == "Sell" ) && bid.first && (self.price <= bid.first.price) 
			match_with_market(bid.first)
		end

	end

	def match_with_market(waiting_order)

		
		if self.shares < waiting_order.shares
			partialorder = self.artwork.orders.new(user_id: waiting_order.user_id, shares: (waiting_order.shares - self.shares), price: waiting_order.price, side: waiting_order.side, expiration_date: waiting_order.expiration_date, status: "Limit")
			waiting_order.refresh_shares_to_be_executed(self.shares)
			waiting_order.change_to_executed(waiting_order.price)
		end

		if self.shares > waiting_order.shares
			partialorder = self.artwork.orders.new(user_id: self.user_id, shares: self.shares - waiting_order.shares, price: self.price, side: self.side, expiration_date: self.expiration_date, status: "Limit")
			self.refresh_shares_to_be_executed(waiting_order.shares)
			
		end

		unless self.shares < waiting_order.shares
			waiting_order.change_to_executed(waiting_order.price)
		end

		self.change_to_executed(waiting_order.price)
		self.produce_ticket(waiting_order)
		self.save

		if partialorder
			partialorder.save
			partialorder.read_and_match(partialorder.artwork.bids, partialorder.artwork.asks)
		end
	end

	def cancelorder
		self.update(status: "Canceled")
	end 

end
