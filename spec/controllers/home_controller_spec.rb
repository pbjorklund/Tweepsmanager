require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    it "returns http sucess" do
      get 'index'
      response.should be_success
    end
  end
end
