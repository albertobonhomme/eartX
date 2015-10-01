class OrdersController < ApplicationController
	
	def create
		@artwork = Artwork.find_by(id: params[:artwork_id])
		@order = @artwork.orders.new(order_params)
		@order.read_and_match(@artwork.bids, @artwork.asks)

		if @order
			@order.save
			redirect_to artwork_path(@artwork)
		else
			render :new
		end

	end

	private

	def order_params
		params.require(:order).permit(:side,:price,:shares,:status,:user_id)
	end
end
