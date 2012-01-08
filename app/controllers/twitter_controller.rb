class TwitterController < ApplicationController
  def followers
    @user = current_user

    #twitter = Twitter::Client.new(:oauth_token => "current_user.token", :oauth_token_secret => "current_user.secret")
    twitter = Twitter::Client.new()

    following = twitter.friend_ids(@user.nickname)
    followers = twitter.follower_ids(@user.nickname)

    not_following_user = following.ids.to_set - followers.ids.to_set
    stalkers = followers.ids.to_set - following.ids.to_set 

    @not_following_user = twitter.users(not_following_user.first(100))
    @stalkers = twitter.users(stalkers.first(100))

    @api_calls_left = twitter.rate_limit_status.remaining_hits
  end

  def following
    @user = current_user
    twitter = Twitter::Client.new()
    twitter.friend_ids(@user.nickname)
  end

  def friends
  end

  def stalkers
  end

  def only_following
  end
  
  def settings
	twitter = Twitter::Client.new()
	@user = twitter.user(current_user.nickname)
  end
end
