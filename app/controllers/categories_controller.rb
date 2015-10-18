class CategoriesController < ApplicationController

	def show
		@productsfiltered = Product.all.where(category_id: params[:id])
	end
end
