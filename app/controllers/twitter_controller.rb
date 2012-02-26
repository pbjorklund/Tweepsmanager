class TwitterController < ApplicationController
  before_filter :signed_in?

  def followers
    respond_to do |format|
      format.html
      format.js do
        @users = twitter.get_followers
        @api_calls_left = get_api_status
      end
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
    check_api_limit do
        @active_user = twitter.unfollow(params[:id])
        respond_to do |format|
          format.html { redirect_to :back, notice: "Stopped following #{params[:id]}" }
          format.js
      end
    end
  end

  def follow
    check_api_limit do
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

  def get_api_calls
    get_api_status.remaining_hits
  end

  def check_api_limit(&action)
    @status ||= get_api_calls
    if(@status > 0)
      begin
        yield
      rescue Twitter::Error::NotFound => nf
        redirect_to :back, :flash => { error: "Not found:" + nf.message }
      rescue Twitter::Error::Forbidden => f
        redirect_to :back, :flash => { error: f.message }
      rescue Twitter::Error::ServiceUnavailable => ua
        redirect_to :back, :flash => { error: ua.message }
      end
    else
      redirect_to :back, :flash => { error: "You are out of api-calls. Please check the bottom of the page, you can see how long you have to wait there" }
    end
  end

end
