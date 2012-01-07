class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    raise auth = request.env["omniauth.auth"].to_yaml
    session[:user_id] = user.id
    #redirect_to root_url, :notice => "Signed in!"
                                         
  end
end
