class AuthorsController < ApplicationController
	def show
		@allartworks = Artwork.all.where(status: "Trading")
		@author = Author.find_by(id: params[:id])
		@artworks = @author.artworks.where(status: "Trading")
		@authors = Author.all
	end
end
