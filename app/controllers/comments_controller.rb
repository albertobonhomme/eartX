class CommentsController < ApplicationController

	def create
		@product = Product.find_by(id: params[:product_id])
		@comment = @product.comments.new(content: params[:comment][:content], user_id: params[:comment][:user_id])
		if @comment.save

			redirect_to product_path(Product.find_by(id: params[:product_id]))
		end
	end

	def edit
		@product = Product.find_by(id: params[:product_id])
		@comment = Comment.find_by(id: params[:id])
	end

	def destroy
		@comment = Comment.find(params[:id])
		@id = @comment.product
		@comment.destroy	
		redirect_to product_path(Product.find_by(id: @id))
	end

	def update
		@product = Product.find_by(id: params[:product_id])
		@comment = Comment.find_by(id: params[:id])
		
		if @comment.update(content: params[:comment][:content])
			redirect_to product_path(Product.find_by(id: params[:product_id]))
		end

	end

	private


end
