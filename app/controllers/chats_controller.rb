class ChatsController < ApplicationController

	def new
		@product = Product.find_by(id: params[:product_id])
		@chat = @product.chats.new
		create
	end

	def create
		@product = Product.find_by(id: params[:product_id])
		@chat = @product.chats.new(buyer_id: current_user.id, seller_id: @product.user.id, product_id: @product.id)
		@chat.messages.new(user: current_user, content: "Hola #{@product.user.name.split(" ")[0]}! Me interesa tu producto #{@product.name}")
		if @chat.save
			redirect_to product_chat_path(@product,@chat)
		else
			render :new
		end
	end

	def show
		@product = Product.find_by(id: params[:product_id])
		@chat = Product.find_by(id: params[:product_id]).chats.find_by(id: params[:id])
		@message = Product.find_by(id: params[:product_id]).chats.find_by(id: params[:id]).messages.new
	end
end
