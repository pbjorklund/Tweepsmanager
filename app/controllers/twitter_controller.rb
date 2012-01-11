class TwitterController < ApplicationController
  def followers
    @user = current_user

    if Rails.env.test?
      @not_following_user = Array.new
      @stalkers = Array.new
      @api_calls_left = Array.new
    else
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
      @following = Array.new
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
    if Rails.env.test?
    else 
      @user = twitter.user(current_user.nickname)
    end
  end
  
  def tweet
    if Rails.env.test?
      #TODO Fix this mess... Get idea of how to test twitter integration
    else 
      twitter.update(params[:tweet])
      render :partial => "SuccessPartial", notice: "Posted #{params[:tweet]} to twitter"
    end
  end
end
