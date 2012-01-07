class TwitterController < ApplicationController
  def followers
    @user = current_user
  end

  def following
  end

  def friends
  end

  def stalkers
  end

  def only_following
  end
end
