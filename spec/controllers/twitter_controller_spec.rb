require 'spec_helper'

describe TwitterController do

  before(:each) do
    controller.stub(:current_user).and_return( FactoryGirl.create(:user))
  end

  describe "GET 'followers'" do
    #Perhaps not optimal, this get's run every time
    before(:each) do
      VCR.use_cassette('followers') do
        get 'followers'
      end
    end

    it "returns http success" do
      response.should be_success
    end

    it "assings follower" do
      assigns(:followers).should_not be_nil
    end

    it "assings api_calls_left" do
      assigns(:api_calls_left).should_not be_nil
    end
  end

  describe "GET 'following'" do
    before(:each) do
      VCR.use_cassette('following') do
        get 'following'
      end
    end

    it "returns http success" do
      response.should be_success
    end

    it "assings following" do
      assigns(:following).should_not be_nil
    end

    it "assings api_calls_left" do
      assigns(:api_calls_left).should_not be_nil
    end
  end


  describe "GET 'friends'" do
    before(:each) do
      VCR.use_cassette('friends') do
        get 'friends'
      end
    end

    it "returns http success" do
      response.should be_success
    end

    it "assings friends" do
      assigns(:friends).should_not be_nil
    end

    it "assings api_calls_left" do
      assigns(:api_calls_left).should_not be_nil
    end
  end

  describe "GET 'stalkers'" do
    before(:each) do
      VCR.use_cassette('stalkers') do
        get 'stalkers'
      end
    end

    it "returns http success" do
      response.should be_success
    end

    it "assings stalkers" do
      assigns(:stalkers).should_not be_nil
    end

    it "assings api_calls_left" do
      assigns(:api_calls_left).should_not be_nil
    end
  end

  describe "GET 'only_following'" do
    before(:each) do
      VCR.use_cassette('only_following') do
        get 'only_following'
      end
    end

    it "returns http success" do
      response.should be_success
    end

    it "assings only_following" do
      assigns(:only_following).should_not be_nil
    end

    it "assings api_calls_left" do
      assigns(:api_calls_left).should_not be_nil
    end
  end

  describe "GET 'settings'" do
    before(:each) do
      VCR.use_cassette('seetings') do
        get 'settings'
      end
    end

    it "returns https success" do
      response.should be_success
    end

    it "assings user" do
      assigns(:user).should_not be_nil
    end
  end


  describe "POST 'tweet'" do
    #Now this assumes that is posts a tweet successfully in the "posts a tweet"
    it "posts a tweet" do
      @request.env['HTTP_REFERER'] = '/twitter/followers'
      VCR.use_cassette('tweet') do
        post 'tweet', tweet: "Spam"
      end
      flash[:notice].should_not be_nil
      response.should redirect_to twitter_followers_path
    end

    it "does not post a duplicate tweet" do
      @request.env['HTTP_REFERER'] = '/twitter/followers'
      VCR.use_cassette('duplicate_tweet') do
        post 'tweet', tweet: "Spam"
      end
      flash[:error].should_not be_nil
      response.should redirect_to twitter_followers_path
    end
  end

  describe "POST 'unfollow'" do
    it "unfollows a user when given a nickname" do
      @request.env['HTTP_REFERER'] = '/twitter/followers'
      VCR.use_cassette('unfollow') do
        post 'unfollow', id: "tweepsmanager"
      end
      response.should redirect_to twitter_followers_path
    end

    it "does not unfollow a user that does not exist" do
      @request.env['HTTP_REFERER'] = '/twitter/followers'
      VCR.use_cassette('unfollow_doesnt_exist') do
        post 'unfollow', id: "jiofewijfeiowjfeowfjew"
      end
      flash[:error].should_not be_nil
      flash[:error].should have_content("not found, could not unfollow")
      response.should redirect_to twitter_followers_path
    end
  end

  describe "POST 'follow'" do
    before(:each) do
      @request.env['HTTP_REFERER'] = '/twitter/followers'
    end

    it "follows a user when given a nickname" do
      VCR.use_cassette('follow') do
        post 'follow', id: "tweepsmanager"
      end
      flash[:notice].should_not be_nil
      response.should redirect_to twitter_followers_path
    end

    it "does not follow a user that does not exist" do
        VCR.use_cassette('follow_doesnt_exist') do
        post 'follow', id: "jiofewijfeiowjfeowfjew"
      end
      flash[:error].should_not be_nil
      flash[:error].should have_content("not found, could not follow")
      response.should redirect_to twitter_followers_path
    end
  end
end
