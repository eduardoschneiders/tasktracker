class SessionController < ApplicationController
  def create
    @session = Session.new session_params

<<<<<<< Updated upstream
    if session[:current_user] = @session.auth
=======
    if current_user = @session.auth
      session[:current_user] = { email: current_user.email, name: current_user.name }
>>>>>>> Stashed changes
      redirect_to root_path
    else
      redirect_to users_signin_path
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
