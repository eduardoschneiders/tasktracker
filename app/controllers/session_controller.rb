class SessionController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new session_params

    if @session.create
      session[:current_user_id] = @session.user.id
      redirect_to root_path
    else
      flash[:notice] = 'Wrong login'
      redirect_to users_signin_path
    end
  end

  def destroy 
    session.delete(:current_user_id)
    flash[:notice] = 'Signed out with success'
    redirect_to root_path
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
