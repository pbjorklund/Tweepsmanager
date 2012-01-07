class HomeController < ApplicationController
  def index
	if current_user
		render layout: "application"
	else
		render layout: "start", action: "start"
	end
  end
end