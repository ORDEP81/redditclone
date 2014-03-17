class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_strong_params)
    if @user.save 
      session[:user_id] = @user.id
      flash[:notice] = 'You are now registered'
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

private
  def user_strong_params
    params.require(:user).permit(:username, :password)
  end
end