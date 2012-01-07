class HomeController < ApplicationController
  def index
	if current_user
		render layout: "start", action: "start"
	else
		render layout: "start", action: "start"
	end
  end

  def login
    
  end
end
