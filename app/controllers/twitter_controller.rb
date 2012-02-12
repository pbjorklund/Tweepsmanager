class TwitterController < ApplicationController
  before_filter :signed_in?

  def followers
    @twitter_users = twitter.get_followers
  end

  def unfollow
    begin
      twitter.unfollow(params[:id])
      redirect_to :back, notice: "Stopped following #{params[:id]}"
    rescue Twitter::Error::NotFound
      redirect_to :back, :flash => { error: "User #{params[:id]} not found, could not unfollow user" }
    rescue Twitter::Error::Forbidden
      redirect_to :back, :flash => { error: "User #{params[:id]} could not be unfollowed" + $! }
    end
  end

  def follow
    begin
      twitter.follow(params[:id])
      redirect_to :back, notice: "Followed #{params[:id]}"
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
