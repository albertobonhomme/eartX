class UsersController < ApplicationController
	before_action :authenticate_user!
	before_filter :base
  
  def profile
    @user = User.find_by(id: params[:user_id])
    render 'users/profile'
  end
  
  private 
  
  def base

    @products_current_user = Product.where(user_id: current_user)
    @products = Product.all
    @categories = Category.all

  end

end
