class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

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

  def update
    if @user.update(user_strong_params)
      flash[:notice] = 'Your profile has been updated'
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
  end


private
  def user_strong_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = 'You are not logged in as that user'
      redirect_to root_path
    end
  end
end