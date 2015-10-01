class UsersController < ApplicationController
	before_action :authenticate_user!
	before_filter :base
  
  def profile
    @user = current_user
    render 'users/profile'
  end
  
  private 
  
  def base
		@offerings = Artwork.offering
		@allartworks = Artwork.trading
		@authors = Author.all
  end

end
