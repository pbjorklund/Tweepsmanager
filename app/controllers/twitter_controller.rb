class TwitterController < ApplicationController
  before_filter :setup_twitter_service

  def followers
    @user = current_user

    @followers = @twitter_service.get_followers
    @api_calls_left = @twitter_service.get_api_calls_left
  end

  #TODO Mark the ones that you are following as following and the ones I don't follow as not following
  def following
    @user = current_user
    @following = @twitter_service.get_following.sort_by(&:screen_name)
  end

  def friends
    @friends = @twitter_service.get_friends
    @friends_count = @twitter_service.get_friends_count
  end

  #TODO This is people that you don't follow. Make sure that you follow them, not unfollow them ;)
  def stalkers
      @stalkers = @twitter_service.get_stalkers
  end

  def only_following
    @only_following = @twitter_service.get_users_not_following_back
  end

  def settings
    @user = @twitter_service.twitter.user(current_user.nickname)
  end

  def tweet
    twitter.update(params[:tweet])
    redirect_to back, notice: "Posted tweet"
  end

  def unfollow
    @twitter_service.twitter.unfollow(params[:id])
    redirect_to :back, notice: "Stopped following #{params[:id]}"
  end

  private
  def setup_twitter_service
    @twitter_service = TwitterFollower.new(current_user)
  end
end
