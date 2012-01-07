class TwitterController < ApplicationController
  def followers
    @user = current_user

    #twitter = Twitter::Client.new(:oauth_token => "current_user.token", :oauth_token_secret => "current_user.secret")
    twitter = Twitter::Client.new()
    # Update your status
    #Twitter.update("Testing the twitter api keys")

    following = twitter.friend_ids(current_user.nickname)
    followers = twitter.follower_ids(current_user.nickname)

    not_following_user = following.ids.to_set - followers.ids.to_set
    stalkers = followers.ids.to_set - following.ids.to_set 

    @following = "Users you follow that don't follow you back: #{not_following_user.count}"
    @followers =  "Users that follow you that you don't follow back: #{stalkers.count}"

    #not_following_user.first(10).each { |user_id| ap Twitter.user(user_id).screen_name }
    #stalkers.first(10).each { |user_id| ap Twitter.user(user_id).screen_name }

    #ap Twitter.users(following.ids.first)

    puts twitter.rate_limit_status.remaining_hits.to_s + " Twitter API request(s) remaining this hour"
  end

  def following
	@users = ["Pelle", "Lisa", "Nisse", "Kalle", "Stina"]
  end

  def friends
  end

  def stalkers
  end

  def only_following
  end
end
