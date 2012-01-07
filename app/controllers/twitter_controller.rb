class TwitterController < ApplicationController
  def followers
    @user = current_user

    #twitter = Twitter::Client.new(:oauth_token => "current_user.token", :oauth_token_secret => "current_user.secret")
    twitter = Twitter::Client.new()

    following = twitter.friend_ids(@user.nickname)
    followers = twitter.follower_ids(@user.nickname)

    not_following_user = following.ids.to_set - followers.ids.to_set
    stalkers = followers.ids.to_set - following.ids.to_set 

    @following = not_following_user.count
    @followers =  stalkers.count

    #not_following_user.first(10).each { |user_id| ap Twitter.user(user_id).screen_name }
    #stalkers.first(10).each { |user_id| ap Twitter.user(user_id).screen_name }

    #ap Twitter.users(following.ids.first)

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
end
