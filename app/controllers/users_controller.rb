class UsersController < ApplicationController
  def signup
    @user = User.new
  end

  def create
    password = CaesarEncrypt.encrypt(user_params[:password], 5)
    @user = User.new user_params.merge(password: password)
    if @user.save
      flash[:notice] = 'User created with success'
      redirect_to root_path
    else
      flash[:notice] = 'Unable to create user'
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
