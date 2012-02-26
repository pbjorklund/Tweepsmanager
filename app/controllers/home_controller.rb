class HomeController < ApplicationController
  def index
  end

  def about
  end

  def api_status
    respond_to do |format|
      format.js { get_api_status }
    end
  end
end
