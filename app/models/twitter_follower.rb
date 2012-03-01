#TODO Thinking about extracting this into a module perhaps
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
  
  def get_followers user = current_user.nickname
    rescue_twitter_unresponsive do
      user_ids = twitter.follower_ids(user).ids
      get_users_from_twitter(user_ids)
    end
  end

  def get_following user = current_user.nickname
    rescue_twitter_unresponsive do
      user_ids = twitter.friend_ids(user).ids
      get_users_from_twitter(user_ids)
    end
  end


  def get_not_following_back user = current_user.nickname
      following_ids = twitter.friend_ids(user).ids
      follower_ids = twitter.follower_ids(user).ids
      only_following_ids = following_ids - follower_ids
      get_users_from_twitter(only_following_ids)
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

  def get_api_status
    twitter.rate_limit_status
  end

  private

  #TODO this needs pagination, badly
  def get_users_from_twitter user_ids
      user_ids.in_groups_of(100, false).map { |group|
        twitter.users(group).select { |u| u.status != nil }
      }.flatten
  end

  def rescue_twitter_unresponsive(&block)
    begin
      yield
    rescue Twitter::Error::ServiceUnavailable
    rescue Twitter::Error::BadGateway
    end
  end
end
