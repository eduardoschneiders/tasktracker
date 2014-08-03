class SessionController < ApplicationController
  def create
    @session = Session.new session_params

    if session[:current_user] = @session.auth
      redirect_to root_path
    else
      flash[:notice] = 'Wrong login'
      redirect_to users_signin_path
    end
  end

  def session_params
    password = CaesarEncrypt.encrypt(params[:session][:password], 5)
    params[:session].merge!(password: password)
    params.require(:session).permit(:email, :password)
  end
end
