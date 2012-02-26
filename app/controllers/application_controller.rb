class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :get_api_status



  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_api_status
    @api_calls_left = twitter.get_api_status
  end

  def twitter
    twitter_service ||= TwitterFollower.new(current_user)
  end

end
