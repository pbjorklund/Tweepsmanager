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
    rescue_over_capacity do
      users = twitter.friend_ids(current_user.nickname).ids.to_set - twitter.follower_ids(current_user.nickname).ids.to_set
      twitter.users(users.first(limit))
    end
  end

  def get_followers(limit = 100)
    rescue_over_capacity do
      follower_ids = twitter.follower_ids(current_user.nickname).ids
      twitter.users(follower_ids.first(limit))
    end
  end

  def get_following(limit = 100)
    rescue_over_capacity do
      following_ids = twitter.friend_ids(current_user.nickname).ids
      twitter.users(following_ids.first(limit))
    end
  end

  def get_stalkers(limit = 100)
    rescue_over_capacity do
      users = twitter.follower_ids(current_user.nickname).ids.to_set - twitter.friend_ids(current_user.nickname).ids.to_set
      twitter.users(users.first(limit))
    end
  end

  def get_friends(limit = 100)
    rescue_over_capacity do
      friends = twitter.follower_ids(current_user.nickname).ids.to_set & twitter.friend_ids(current_user.nickname).ids.to_set
      twitter.users(friends.first(limit))
    end
  end

  #TODO Make this in a better way. For instance when doing pagination
  def get_friends_count
    rescue_over_capacity do
      friends = twitter.follower_ids(current_user.nickname).ids.to_set & twitter.friend_ids(current_user.nickname).ids.to_set
      friends.count
    end
  end

  def get_api_calls_left
    rescue_over_capacity do
      twitter.rate_limit_status.remaining_hits
    end
  end

  def follow(nickname)
    rescue_over_capacity do
      twitter.follow(nickname)
    end
  end

  def unfollow(nickname)
    rescue_over_capacity do
      twitter.unfollow(nickname)
    end
  end

  def update(tweet)
    rescue_over_capacity do
      twitter.update(tweet)
    end
  end

  private
  def rescue_over_capacity(&block)
    begin
      yield
    rescue Twitter::Error::ServiceUnavailable
    end
  end
end
