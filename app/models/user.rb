class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save { self.email = email.downcase }
  
  has_many :buyers, :class_name => 'Ticket', :foreign_key => 'buyer_id'
  has_many :sellers, :class_name => 'Ticket', :foreign_key => 'seller_id'
  has_many :orders
  
  def get_portfolio
  	portfolio = [ ]
	  	get_artworks.each do |id|
	  		portfolio.push([Artwork.find_by(id: id),get_shares(id), get_historic_price(get_shares(id), id)])
	  	end

	  return portfolio
  end

  def sum_portfolio_pl
  	sum = 0
	  	self.buyers.each do |ticket|
	  		sum -= (ticket.shares * ticket.price)
	  	end

	  	self.sellers.each do |ticket|
	  		sum += (ticket.shares * ticket.price)
	  	end
	  	self.get_artworks.each do |id|
	  		sum += (self.get_shares(id) * Artwork.find_by(id: id).last_price.to_f)
	  	end

	return sum
  end

  def suminvestment_total
  	sum = 0
	  	self.buyers.each do |ticket|
	  		sum += ticket.shares * ticket.price
	  	end
	  return sum
  end 

  def sum_portfolio_unrealizedpl
  	sum = 0
  		get_portfolio.each do |ticket|
	  	sum += (((ticket[0]).last_price.to_f - ticket[2].to_f) * ticket[1].to_f)
	  	end
	  	return sum
  end

  def suminvestment_activeportfolio
  	sum = 0
  		get_portfolio.each do |ticket|
  			sum += (ticket[1].to_f * ticket[2].to_f)
  		end
  		return sum
  end


  def get_artworks
  	artworks_portfolio = [ ]
	  	
	  	self.buyers.each do |ticket|
	  		artworks_portfolio.push(ticket.artwork.id)
	  	end

	return artworks_portfolio.uniq
  end

  def get_shares(artwork_id)
  	sum = 0
	  	Ticket.where(artwork_id: artwork_id, buyer_id: self.id).each do |ticket|
	  		sum += ticket.shares
	  	end

	  	Ticket.where(artwork_id: artwork_id, seller_id: self.id).each do |ticket|
	  		sum -= ticket.shares
	  	end

  	return sum
  end

  def get_historic_price(shares, artwork_id)
  	result = [ ]
  	sum = 0	
  		get_tape(artwork_id).each do |price, volume|
  			if sum < shares
  				sum += volume
  				result.push([price, volume])
  			end
  		end
  	return calculate_historic_price(result, sum, shares)
  end

  def calculate_historic_price(result, sum, shares)

  	if result.length > 0
	  	result[result.length - 1][1] = result[result.length - 1][1] - (sum - shares)
	  	total = 0
		  	result.each do |price, volume|
		  		total += price * volume / shares
		  	end
		  return total
	end
  end

  def get_tape(artwork_id)

  		prices_and_sizes_array = [ ]
  		
  		Ticket.where(artwork_id: artwork_id, buyer_id: self.id).order("created_at DESC").each do |ticket|
  			prices_and_sizes_array.push([ticket.price, ticket.shares])
  		end
  		return prices_and_sizes_array
  end

end
