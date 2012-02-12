class HomeController < ApplicationController
  def index
    current_user.refresh_followers
    current_user.refresh_following
  end
end
