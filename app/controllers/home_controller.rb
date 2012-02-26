class HomeController < ApplicationController
  def index
  end

  def about
  end

  def userstatus
    respond_to do |format|
      format.js { @status = get_api_status }
    end
  end
end
