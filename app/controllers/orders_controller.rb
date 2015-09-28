class OrdersController < ApplicationController
	
	def create
		@artwork = Artwork.find_by(id: params[:artwork_id])
		@order = @artwork.orders.new(order_params)

		if @artwork.asks.first
			if (@order.side == "Buy") && (@order.price >= @artwork.asks.first.price)
				if (@order.shares < @artwork.asks.first.shares)
					@artwork.asks.first.update(shares: (@artwork.asks.first.shares - @order.shares) )
					@order.update(status: "Executed")
				elsif (@order.shares > @artwork.asks.first.shares)
					@order.update(shares: (@order.shares - @artwork.asks.first.shares))
					@artwork.asks.first.update(status: "Executed")
				elsif (@order.shares = @artwork.asks.first.shares)
					@order.update(status: "Executed")
					@artwork.asks.first.update(status: "Executed")
				end
			end
		end

		if @artwork.bids.first
			if (@order.side == "Sell") && (@order.price <= @artwork.bids.first.price)
				if (@order.shares < @artwork.bids.first.shares)
					@artwork.bids.first.update(shares: (@artwork.bids.first.shares - @order.shares) )
					@order.update(status: "Executed")
				elsif (@order.shares > @artwork.bids.first.shares)
					@order.update(shares: (@order.shares - @artwork.bids.first.shares))
					@artwork.bids.first.update(status: "Executed")
				elsif (@order.shares = @artwork.bids.first.shares)
					@order.update(status: "Executed")
					@artwork.bids.first.update(status: "Executed")
				end
				
			end
		end

		
		if @order

			@order.save
			
			redirect_to artwork_path(@artwork)
		else
			render :new
		end

	end

	private

	def order_params
		params.require(:order).permit(:side,:price,:shares,:status)
	end
end
