class TwitterController < ApplicationController
  def followers
    @user = current_user

    if Rails.env.test?
      @followers = Array.new
      @api_calls_left = Array.new
    else

      @followers = get_followers
      @api_calls_left = get_api_calls_left
    end
  end

  def following
    @user = current_user
    if Rails.env.test?
      @following = Array.new
    else 
      @following = get_following.sort!{ |a,b| a.screen_name.downcase <=> b.screen_name.downcase }
    end
  end

  def friends
    #TODO
    @friends = Array.new
  end

  def stalkers
      @stalkers = get_stalkers
  end

  def only_following
    @only_following = get_users_not_following_back
  end

  def settings
    if Rails.env.test?
    else 
      @user = twitter.user(current_user.nickname)
    end
  end
  
  def tweet
	tweet = params[:tweet]
	twitter = Twitter::Client.new()
	#twitter.update(tweet)
	@message = "Success"
	render :partial => "SuccessPartial"
  end
end
