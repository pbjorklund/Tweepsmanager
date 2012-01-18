class TwitterController < ApplicationController
  before_filter :setup_twitter_service

  def followers
    @user = current_user

    @followers = twitter.get_followers
    @api_calls_left = twitter.get_api_calls_left
  end

  #TODO Mark the ones that you are following as following and the ones I don't follow as not following
  def following
    @user = current_user
    @following = twitter.get_following.sort_by(&:screen_name)
  end

  def friends
    @friends = twitter.get_friends
    @friends_count = twitter.get_friends_count
  end

  #TODO This is people that you don't follow. Make sure that you follow them, not unfollow them ;)
  def stalkers
      @stalkers = twitter.get_stalkers
  end

  def only_following
    @only_following = twitter.get_users_not_following_back
  end

  def settings
    @user = twitter.twitter.user(current_user.nickname)
  end

  def tweet
    twitter.update(params[:tweet])
    redirect_to back, notice: "Posted tweet"
  end

  def unfollow
    twitter.twitter.unfollow(params[:id])
    redirect_to :back, notice: "Stopped following #{params[:id]}"
  end

  def twitter
    @twitter_service
  end

  private
  def setup_twitter_service
    @twitter_service = TwitterFollower.new(current_user)
  end
end
