class TwitterController < ApplicationController
  before_filter :signed_in?

  def followers
    respond_to do |format|
      format.html 
      format.js do
        follower_ids = twitter.get_follower_ids params[:user]
        @users = twitter.get_followers_for_page follower_ids, (params[:page] || 0)
        @pages = follower_ids.count / 100
      end
    end
  end

  def following
    respond_to do |format|
      format.html
      format.js { @users = twitter.get_following params[:user] }
    end
  end

  def not_following_back
    respond_to do |format|
      format.html
      format.js { @users = twitter.get_not_following_back params[:user] }
    end
  end

  def unfollow
    rescue_twitter_exceptions do
      @active_user = twitter.unfollow(params[:id])
      respond_to do |format|
        format.html { redirect_to :back, notice: "Stopped following #{params[:id]}" }
        format.js
      end
    end
  end

  def follow
    rescue_twitter_exceptions do
      @active_user = twitter.follow(params[:id])

      respond_to do |format|
        format.html { redirect_to :back, notice: "Followed #{params[:id]}" }
        format.js
      end
    end
  end

  private
  def twitter
    twitter_service ||= TwitterFollower.new(current_user)
  end

  def signed_in?
    unless current_user
      redirect_to "/auth/twitter", notice: "Please sign in!"
    end
  end

  def rescue_twitter_exceptions(&action)
    begin
      yield
    rescue Twitter::Error::NotFound => nf
      redirect_to :back, :flash => { error: "Not found:" + nf.message }
    rescue Twitter::Error::Forbidden => f
      redirect_to :back, :flash => { error: f.message }
    rescue Twitter::Error::ServiceUnavailable => ua
      redirect_to :back, :flash => { error: ua.message }
    end
  end
end
