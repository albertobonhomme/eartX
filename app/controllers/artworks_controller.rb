class ArtworksController < ApplicationController
	before_filter :base
	
	def index

	end

	def show
		@artwork = Artwork.find_by(id: params[:id])
		@order = Order.new

		@bids = @artwork.bids
		@asks = @artwork.asks

		@tickets = @artwork.last_tickets
	end

	def offerings
		@order = Order.new
	end

	private

	def base
		@offerings = Artwork.offering
		@allartworks = Artwork.trading
		@authors = Author.all
	end
end
