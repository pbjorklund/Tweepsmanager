require 'spec_helper'

describe TwitterController do

  describe "GET 'following'" do
    it "returns http success" do
      pending "need twitter mock" do
        get 'following'
        response.should be_success
      end
    end
  end

  describe "GET 'followers'" do
    it "returns http success" do
      pending "need twitter mock" do
        get 'followers'
        response.should be_success
      end
    end
  end

  describe "GET 'friends'" do
    it "returns http success" do
      pending "need twitter mock" do
        get 'friends'
        response.should be_success
      end
    end
  end

  describe "GET 'stalkers'" do
    it "returns http success" do
      pending "need twitter mock" do
        get 'stalkers'
        response.should be_success
      end
    end
  end

  describe "GET 'only_following'" do
    it "returns http success" do
      pending "need twitter mock" do
        get 'only_following'
        response.should be_success
      end
    end
  end

  describe "GET 'settings'" do
    it "returns http success" do
      pending "need twitter mock" do
        get 'settings'
        response.should be_success
      end
    end
  end

  describe "GET 'tweet'" do
    it "returns http success" do
      pending "need twitter mock" do
        get 'tweet'
        response.should be_success
      end
    end
  end

end
