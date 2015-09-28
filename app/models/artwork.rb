class Artwork < ActiveRecord::Base
	belongs_to :author
	has_many :orders
	has_many :tickets

	def ipo_shares_subscribed
		sum = 0
			self.orders.where(status: "Offering").each do |ipo_order|
				sum += ipo_order.shares
			end
		return sum
	end

	def ipo_eur_subscribed
		self.ipo_shares_subscribed * self.ipo_price / 1000000
	end

	def ipo_percentage_subscribed
		self.ipo_eur_subscribed / (self.outstanding_shares / 1000000 * self.ipo_price.to_f) * 100
	end

	def self.offering
		all.where(status: "Offering")
	end

	def self.trading
		all.where(status: "Trading")
	end

	def bids
		orders.limit(3).where(side: "Buy", status: "Limit").order("price DESC")
	end

	def asks
		orders.limit(3).where(side: "Sell", status: "Limit").order("price ASC")
	end
end
