class TwitterFollower
extend ActiveModel::Naming

  def initialize(user)
    @current_user = user
  end

  attr :current_user

  def twitter
    @twitter ||= Twitter::Client.new(:oauth_token => @current_user.auth.token, :oauth_token_secret => @current_user.auth.secret)
  end

  def get_follower_ids user = current_user.nickname
    rescue_twitter_unresponsive do
      ids = get_ids_from_twitter :follower_ids, user
    end
  end

  def get_following_ids user
    rescue_twitter_unresponsive do
      get_ids_from_twitter :friend_ids, user
    end
  end

  def get_not_following_back_ids user
    rescue_twitter_unresponsive do
      following_ids = get_ids_from_twitter :friend_ids, user
      follower_ids = get_ids_from_twitter :follower_ids, user

      only_following_ids = following_ids - follower_ids
    end
  end

  def get_users_for_page ids, page
    rescue_twitter_unresponsive do
      get_users_from_twitter(ids, page.to_i)
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

  def get_api_status
    twitter.rate_limit_status
  end

  private
  def get_ids_from_twitter method, username
    cursor = "-1"
    follower_ids = []
    while cursor != 0 do
      twitter_response = twitter.send method, username, {cursor: cursor }
      follower_ids += twitter_response.ids
      cursor = twitter_response.next_cursor
    end
    follower_ids
  end

  def get_users_from_twitter user_ids, page = 0
    user_groups = user_ids.in_groups_of(100, false)
    twitter.users(user_groups[page]).select { |u| u.status != nil }.flatten
  end

  def rescue_twitter_unresponsive(&block)
    begin
      yield
    rescue Twitter::Error::ServiceUnavailable
    rescue Twitter::Error::BadGateway
    end
  end
end
