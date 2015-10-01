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

	def last_tickets
		tickets.limit(3).order("created_at DESC")
	end

	def bids
		orders.where(side: "Buy", status: "Limit").order("price DESC")
	end

	def asks
		orders.where(side: "Sell", status: "Limit").order("price ASC")
	end

	def get_3_bids
		bids_array = [ ]
			self.bids.each do |bid|
				bids_array.push(bid.price)
			end
		return bids_array.uniq
	end

	def get_3_offers
		offers_array = [ ]
			self.asks.each do |ask|
				offers_array.push(ask.price)
			end

			return offers_array.uniq
	end


	def count_bid_shares
		bid_shares_array = [ ]
			self.get_3_bids.each do |price|
				sum = 0
					self.bids.where(price: price).each do |order|
						sum += order.shares
					end
				bid_shares_array.push(sum)
			end
		return bid_shares_array
	end

	def count_offer_shares
		offer_shares_array = [ ]
			self.get_3_offers.each do |price|
				sum = 0
					self.asks.where(price: price).each do |order|
						sum += order.shares
					end
				offer_shares_array.push(sum)
			end
		return offer_shares_array
	end

	def percentage_change_since_ipo
		(self.last_price - self.ipo_price) / self.ipo_price * 100
	end

	def set_new_last_price(price)
		update(last_price: price)
	end

	def day_volume
		sum = 0
		tickets.where("created_at >= ?", Time.zone.now.beginning_of_day).each { |a| sum += a.shares }
		return sum
	end

	def max_day
		tickets.where("created_at >= ?", Time.zone.now.beginning_of_day).order("price DESC")
	end

	def min_day
		tickets.where("created_at >= ?", Time.zone.now.beginning_of_day).order("price ASC")
	end

	def today
		tickets.where("created_at >= ?", Time.zone.now.beginning_of_day)
	end

end
