class SessionController < ApplicationController
  def create
    @session = Session.new session_params

    if session[:current_user] = @session.auth
      redirect_to root_path
    else
      redirect_to users_signin_path
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
