class TwitterController < ApplicationController
  def followers
    @user = current_user


    unless Rails.env.test?
      following = twitter.friend_ids(@user.nickname)
      followers = twitter.follower_ids(@user.nickname)

      not_following_user = following.ids.to_set - followers.ids.to_set
      stalkers = followers.ids.to_set - following.ids.to_set 

      @not_following_user = twitter.users(not_following_user.first(100))
      @stalkers = twitter.users(stalkers.first(100))

      @api_calls_left = twitter.rate_limit_status.remaining_hits
    end
  end

  def following
    @user = current_user
    if Rails.env.test?
      @following = []
    else 
      friends = twitter.friend_ids
      @following = twitter.users(friends.ids.first(100))
	  @following.sort!{ |a,b| a.screen_name.downcase <=> b.screen_name.downcase }
    end
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
  
  def tweet
	tweet = params[:tweet]
	twitter = Twitter::Client.new()
	#twitter.update(tweet)
	@message = "Success"
	render :partial => "SuccessPartial"
  end
end
