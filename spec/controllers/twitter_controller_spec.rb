require 'spec_helper'

describe TwitterController do

  describe "GET 'following'" do
    it "returns http success" do
      get 'following'
      response.should be_success
    end
  end

  describe "GET 'followers'" do
    it "returns http success" do
      get 'followers'
      response.should be_success
    end
  end

  describe "GET 'friends'" do
    it "returns http success" do
      get 'friends'
      response.should be_success
    end
  end

  describe "GET 'stalkers'" do
    it "returns http success" do
      get 'stalkers'
      response.should be_success
    end
  end

  describe "GET 'only_following'" do
    it "returns http success" do
      get 'only_following'
      response.should be_success
    end
  end

  describe "GET 'settings'" do
    it "returns http success" do
      get 'settings'
      response.should be_success
    end
  end

  describe "GET 'tweet'" do
    it "returns http success" do
      get 'tweet'
      response.should be_success
    end
  end

end
