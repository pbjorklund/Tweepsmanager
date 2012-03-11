class TwitterController < ApplicationController
  before_filter :signed_in?

  def followers
    respond_to do |format|
      format.html { render "shared/users" }
      format.js { render_users_with :get_follower_ids }
    end
  end

  def following
    respond_to do |format|
      format.html { render "shared/users" }
      format.js { render_users_with :get_following_ids }
    end
  end

  def not_following_back
    respond_to do |format|
      format.html { render "shared/users" }
      format.js { render_users_with :get_not_following_back_ids }
    end
  end

  respond_to :js
  def unfollow
    render_error_on_twitter_rescue { @active_user = twitter.unfollow(params[:id]) }
  end

  respond_to :js
  def follow
    render_error_on_twitter_rescue { @active_user = twitter.follow(params[:id]) }
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

  def render_users_with method
    render_error_on_twitter_rescue do
      ids = twitter.send(method, params[:user])
      @users = twitter.get_users_for_page ids, (params[:page] || 0)
      @pages = ids.count / 100
      render "shared/users"  
    end
  end

  def render_error_on_twitter_rescue &block
    begin
      yield
    rescue Twitter::Error => e
      @api_status = twitter.get_api_status
      @error = e.message
      render "shared/error"
    end
  end
end
