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

	def edit
		@artwork = Artwork.find_by(id: params[:artwork_id])
		@order = Order.find_by(id: params[:id])
	end

	def update
		@artwork = Artwork.find_by(id: params[:artwork_id])
		@order = Order.find_by(id: params[:id])
		if @order.update(order_params)
			@order.read_and_match(@artwork.bids, @artwork.asks)
			@order.save
			flash[:notice] = "Order edited successfully"
			redirect_to profile_tradingorders_path
		else
			render :new
		end

	end

	def destroy
		@order = Order.find(params[:id])
		@order.destroy 
		redirect_to action: "tradingorders", controller: "users"
	end

	private

	def order_params
		params.require(:order).permit(:side,:price,:shares,:status,:user_id)
	end
end
