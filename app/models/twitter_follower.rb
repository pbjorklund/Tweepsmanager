class TwitterFollower
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
