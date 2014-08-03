class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.where(email: session[:current_user][:email]).first if session[:current_user]
  end

  def can_access_logged
    unless current_user
      flash[:notice] = "You don't have permission to access this page"
      redirect_to root_path
    end
  end

  def can_access_unlogged
    if current_user
      redirect_to root_path
    end
  end
end