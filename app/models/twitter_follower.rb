class TwitterFollower
  def initialize(user)
    @current_user = user
  end

  attr :current_user

  #TODO Move this out to resque
  def twitter
    @twitter ||= Twitter::Client.new(:oauth_token => @current_user.auth.token, :oauth_token_secret => @current_user.auth.secret)
  end


  def get_users_not_following_back(limit = 100)
    rescue_twitter_unresponsive do
      users = twitter.friend_ids(current_user.nickname).ids.to_set - twitter.follower_ids(current_user.nickname).ids.to_set
      twitter.users(users.first(limit))
    end
  end

  def get_followers(limit = 100, excluded_ids = [])
    rescue_twitter_unresponsive do

      follower_ids = twitter.follower_ids(current_user.nickname).ids

      current_follower_ids = current_user.followers.map { |f| f.id }

      follower_ids = follower_ids - current_follower_ids

      #TODO Save suspended users somewhere, do not query twitter for them
      followers = follower_ids.in_groups_of(limit, false).map { |fg| twitter.users(fg).select { |u| u.status != nil } }
      followers.flatten
    end
  end

  def get_following(limit = 100)
    rescue_twitter_unresponsive do
      following_ids = twitter.friend_ids(current_user.nickname).ids
      following = following_ids.in_groups_of(limit, false).map { |fg| twitter.users(fg).select { |u| u.status != nil } }
      following.flatten
    end
  end

  def get_stalkers(limit = 100)
    rescue_twitter_unresponsive do
      users = twitter.follower_ids(current_user.nickname).ids.to_set - twitter.friend_ids(current_user.nickname).ids.to_set
      twitter.users(users.first(limit))
    end
  end

  def get_friends(limit = 100)
    rescue_twitter_unresponsive do
      friends = twitter.follower_ids(current_user.nickname).ids.to_set & twitter.friend_ids(current_user.nickname).ids.to_set
      twitter.users(friends.first(limit))
    end
  end

  #TODO Make this in a better way. For instance when doing pagination
  def get_friends_count
    rescue_twitter_unresponsive do
      friends = twitter.follower_ids(current_user.nickname).ids.to_set & twitter.friend_ids(current_user.nickname).ids.to_set
      friends.count
    end
  end

  def get_api_calls_left
    rescue_twitter_unresponsive do
      twitter.rate_limit_status.remaining_hits
    end
  end

  def follow(nickname)
    rescue_twitter_unresponsive do
      twitter.follow(nickname)
    end
  end

  def unfollow(nickname)
    rescue_twitter_unresponsive do
      twitter.unfollow(nickname)
    end
  end

  def update(tweet)
    rescue_twitter_unresponsive do
      twitter.update(tweet)
    end
  end

  private
  def rescue_twitter_unresponsive(&block)
    begin
      yield
    rescue Twitter::Error::ServiceUnavailable
    rescue Twitter::Error::BadGateway
    end
  end
end
