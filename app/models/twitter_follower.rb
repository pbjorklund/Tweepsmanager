class TwitterFollower
extend ActiveModel::Naming

  def initialize(user)
    @current_user = user
  end

  attr :current_user

  #TODO Move this out to resque
  def twitter
    @twitter ||= Twitter::Client.new(:oauth_token => @current_user.auth.token, :oauth_token_secret => @current_user.auth.secret)
  end

  def get_followers(limit = 100, excluded_ids = [])
    rescue_twitter_unresponsive do
      user_ids = twitter.follower_ids(current_user.nickname).ids
      users = []
      user_ids.in_groups_of(100, false).each { |group| users.push(twitter.users(group).select { |u| u.status != nil }) }
      users.flatten
    end
  end

  def get_following(limit = 100, excluded_ids = [])
    rescue_twitter_unresponsive do
      user_ids = twitter.friend_ids(current_user.nickname).ids
      users = []
      user_ids.in_groups_of(100, false).each { |group| users.push(twitter.users(group).select { |u| u.status != nil }) }
      users.flatten
    end
  end

  def get_not_following_back(limit = 100, excluded_ids = [])
      following_ids = twitter.friend_ids(current_user.nickname).ids
      follower_ids = twitter.follower_ids(current_user.nickname).ids
      only_following_ids = following_ids - follower_ids
      users = []
      only_following_ids.in_groups_of(100, false).each { |group| users.push(twitter.users(group).select { |u| u.status != nil }) }
      users.flatten
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

  def get_api_status
    twitter.rate_limit_status
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
