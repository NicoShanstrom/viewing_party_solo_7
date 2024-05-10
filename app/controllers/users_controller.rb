class UsersController < ApplicationController
   before_action :set_user, only: [:discover, :movies, :show, :top_rated_movies]
   def new
      @user = User.new
   end

   def show
  
   end
   
   def discover
   
   end

   def create
      user = User.new(user_params)
      if user.save
         flash[:success] = 'Successfully Created New User'
         redirect_to user_path(user)
      else
         flash[:error] = "#{error_message(user.errors)}"
         redirect_to register_user_path
      end   
   end

private

  def user_params
      params.require(:user).permit(:name, :email)
  end

  def set_user
      @user = User.find(params[:id])
  end
end