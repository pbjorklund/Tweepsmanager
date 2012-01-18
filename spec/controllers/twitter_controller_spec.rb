require 'spec_helper'

describe TwitterController do
  before(:each) do
    controller.stub(:current_user).and_return(User.first)
    twitter = TwitterFollower.new(User.first)
    #TODO: Mock valid twitter response
    controller.stub(:twitter).and_return(twitter)
    twitter.stub(:get_users_not_following_back).and_return(Array.new)
    twitter.stub(:get_followers).and_return(Array.new)
    twitter.stub(:get_following).and_return(Array.new)
    twitter.stub(:get_stalkers).and_return(Array.new)
    twitter.stub(:get_friends).and_return(Array.new)
    twitter.stub(:get_friends_count).and_return(Array.new)
    twitter.stub(:get_api_calls_left).and_return(Array.new)

    controller.stub(:twitter).and_return(twitter)

  end

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

    describe "GET 'only_following'" do
      it "returns http success" do
        get 'only_following'
        response.should be_success
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
end
