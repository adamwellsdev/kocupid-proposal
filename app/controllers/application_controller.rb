class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :ensure_logged_in, :current_user

  private

  def current_user
  	return nil unless session[:token]
  	@current_user ||= User.find_by_session_token(session[:token]);
  end

  def logged_in?
  	!!current_user
  end

  def log_in!(user)
  	@current_user = user
  	session[:token] = user.reset_session_token!
  end

  def log_out!
  	current_user && current_user.reset_session_token!
  	session[:token] = nil
  end

  def ensure_logged_in
  	render json: { error: "Must be logged in to do that!" } unless logged_in?
  end
end
