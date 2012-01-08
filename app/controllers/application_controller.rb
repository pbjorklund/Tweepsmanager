class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :twitter

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def twitter
    Twitter::Client.new()
  end
end
