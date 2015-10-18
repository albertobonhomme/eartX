class ProductsController < ApplicationController
		
	
	def index
		@products = Product.where(vendido: "No")
		@categories = Category.all
	end

	def show
		@product = Product.find_by(id: params[:id])
		@comments = @product.comments.order("Updated_at DESC")
		@comment = Product.find_by(id: params[:id]).comments.new
		@chat = Chat.find_by(buyer_id: current_user, seller_id: @product.user, product_id: @product)
	end

	def new
		@product = Product.new
	end

	def create
		@product = current_user.products.new(price: params[:product][:price], name: params[:product][:name],brand: params[:product][:brand], description: params[:product][:description], image: params[:product][:image], size: params[:product][:size], status: params[:product][:status], category_id: params[:product][:category_id])

		if @product.save
			redirect_to profile_path(current_user)
		else
			render :new
		end
	end

	def destroy
		@product = Product.find(params[:id])

		if @product.destroy	
			redirect_to profile_path(current_user)
		end
	end

	def sold
		@product = Product.find_by(id: params[:product_id])
		@product.vendido = "Si"
		@product.save

		redirect_to profile_path(current_user)
	end

	private

end


