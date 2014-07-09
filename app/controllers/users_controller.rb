class UsersController < ApplicationController
  def signup
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      render action: :signup
    end
  end

  def signin
    @session = Session.new
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
