class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login
  def current_user
    User.find(session[:userid])
  end

  helper_method :current_user

  def require_login
    redirect_to "/" unless  session[:userid]
  end
end
