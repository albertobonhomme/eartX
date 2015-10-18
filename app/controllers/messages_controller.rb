class MessagesController < ApplicationController

	def create

		@chat = Chat.find_by(id: params[:chat_id])
		@product = @chat.product
		@message = @chat.messages.new(user_id: current_user.id, content: params[:message][:content])

		if @message.save
			self.get_new_inbox_receiver(User.find_by(id: @chat.buyer_id), User.find_by(id: @chat.seller_id), @chat)
			redirect_to product_chat_path(@product,@chat)
		else
			render :new
		end
	end

	def get_new_inbox_receiver(buyer, seller, chat)
		if current_user == buyer
			add_unread_message_seller(chat)
		elsif current_user == seller 
			add_unread_message_buyer(chat)
		end
	end

	def add_unread_message_seller(chat)
		chat.seller_new = 1
		chat.save
	end

	def add_unread_message_buyer(chat)
		chat.buyer_new = 1
		chat.save
	end
end
