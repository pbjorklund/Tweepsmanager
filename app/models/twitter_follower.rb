class TwitterFollower
  def initialize(user)
    @current_user = user
  end

  attr :current_user

  #TODO Move this out to resque
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
