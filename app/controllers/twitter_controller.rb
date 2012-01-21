class TwitterController < ApplicationController
  before_filter :setup_twitter_service

  def followers
    @followers = twitter.get_followers
    @api_calls_left = twitter.get_api_calls_left
  end

  #TODO Get users that I follow that follow me back, get users that I follow that don't follow me back
  def following
    @following = twitter.get_following.sort_by(&:screen_name)
    @api_calls_left = twitter.get_api_calls_left
  end

  def friends
    @friends = twitter.get_friends
    @friends_count = twitter.get_friends_count
    @api_calls_left = twitter.get_api_calls_left
  end

  #TODO This is people that you don't follow. Make sure that you follow them, not unfollow them ;)
  def stalkers
    @stalkers = twitter.get_stalkers
    @api_calls_left = twitter.get_api_calls_left
  end

  def only_following
    @only_following = twitter.get_users_not_following_back
    @api_calls_left = twitter.get_api_calls_left
  end

  def settings
    @user = twitter.twitter.user(current_user.nickname)
  end

  def tweet
    begin
      twitter.update(params[:tweet])
      redirect_to :back, notice: "Posted tweet"
    rescue Twitter::Error::Forbidden
      redirect_to :back, :flash => { error: "No post" }
    end
  end

  def unfollow
    begin
      twitter.unfollow(params[:id])
      redirect_to :back, notice: "Stopped following #{params[:id]}"
    rescue Twitter::Error::NotFound
      redirect_to :back, :flash => { error: "User #{params[:id]} not found, could not unfollow user" }
    end
  end

  def follow
    begin
      twitter.follow(params[:id])
      redirect_to :back, notice: "Followed #{params[:id]}"
    rescue Twitter::Error::NotFound
      redirect_to :back, :flash => { error: "User #{params[:id]} not found, could not follow user" }
    end
  end

  private
  def twitter
    @twitter_service
  end

  def setup_twitter_service
    @twitter_service = TwitterFollower.new(current_user)
  end
end
