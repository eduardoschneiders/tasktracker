class UsersController < ApplicationController
  before_filter :can_access_unlogged, only: [:signup, :signin, :create]
  before_filter :can_access_logged, only: [:edit, :update]

  def signup
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = 'User created with success'
      redirect_to root_path
    else
      flash[:notice] = 'Unable to create user'
      render action: :signup
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(user_params)
    flash[:notice] = 'Profile edited with success'
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
