class SessionsController < ApplicationController
  def create
    user = create_user(request.env["omniauth.auth"])
    if user.nil?
      redirect_to root_url, :notice => "Could not sign in"
    else
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, :flash => { error: "Something went wrong, you were not signed in. Please try again." }
  end

  private
  def create_user(auth)
    user = User.create_with_omniauth(auth)
  end
end
