class TwitterController < ApplicationController
  before_filter :signed_in?

  def followers
      respond_to do |format|
        format.html
        format.js { @users = twitter.get_followers }
      end
  end

  def following
    respond_to do |format|
      format.html
      format.js { @users = twitter.get_following }
    end
  end

  def not_following_back
    respond_to do |format|
      format.html
      format.js { @users = twitter.get_not_following_back }
    end
  end

  def unfollow
    begin
      @active_user = twitter.unfollow(params[:id])
      respond_to do |format|
        format.html { redirect_to :back, notice: "Stopped following #{params[:id]}" }
        format.js
      end
    rescue Twitter::Error::NotFound
      redirect_to :back, :flash => { error: "User #{params[:id]} not found, could not unfollow user" }
    rescue Twitter::Error::Forbidden
      redirect_to :back, :flash => { error: "User #{params[:id]} could not be unfollowed" + $! }
    end
  end

  def follow
    begin
      @active_user = twitter.follow(params[:id])

      respond_to do |format|
        format.html { redirect_to :back, notice: "Followed #{params[:id]}" }
        format.js
      end
    rescue Twitter::Error::NotFound
      redirect_to :back, :flash => { error: "User #{params[:id]} not found, could not follow user" }
    rescue Twitter::Error::Forbidden
      redirect_to :back, :flash => { error: "User #{params[:id]} has been suspended and could not be followed" }
    end
  end

  private
  def twitter
    @twitter_service ||= TwitterFollower.new(current_user)
  end

  def signed_in?
    unless current_user
      redirect_to "/auth/twitter", notice: "Please sign in!"
    end

  end
end
