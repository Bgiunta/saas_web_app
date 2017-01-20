class UsersController < ApplicationController
  # GET to /users/:id
  #redirect_to user_path( params[:user_id] )
  def show
    @user = User.find( params[:id] )
  end
end