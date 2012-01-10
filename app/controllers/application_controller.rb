class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :twitter, :get_not_following_user, :get_followers, :get_following, :unfollow_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def twitter
    @twitter ||= Twitter::Client.new(:oauth_token => current_user.token, :oauth_token_secret => current_user.secret)
  end

  def get_users_not_following_back(limit = 100)
    users = twitter.friend_ids(current_user.nickname).ids.to_set - twitter.follower_ids(current_user.nickname).ids.to_set
    twitter.users(users.first(limit))
  end

  def get_followers(limit = 100)
    follower_ids = twitter.follower_ids(current_user.nickname).ids
    twitter.users(follower_ids.first(limit))
  end

  def get_following(limit = 100)
    following_ids = twitter.friend_ids(current_user.nickname).ids
    twitter.users(following_ids.first(limit))
  end

  def get_stalkers(limit = 100)
    users = twitter.follower_ids(current_user.nickname).ids.to_set - twitter.friend_ids(current_user.nickname).ids.to_set
    twitter.users(users.first(limit))
  end

  def get_friends(limit = 100)
    friends = twitter.follower_ids(current_user.nickname).ids.to_set & twitter.friend_ids(current_user.nickname).ids.to_set
    twitter.users(friends.first(limit))
  end

  #TODO Make this in a better way. For instance when doing pagination
  def get_friends_count
    friends = twitter.follower_ids(current_user.nickname).ids.to_set & twitter.friend_ids(current_user.nickname).ids.to_set
    friends.count
  end

  def get_api_calls_left
    twitter.rate_limit_status.remaining_hits
  end
end
