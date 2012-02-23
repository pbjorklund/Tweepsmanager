require 'spec_helper'

describe TwitterController do

  before(:each) do
    User.delete_all
    controller.stub(:current_user).and_return( FactoryGirl.create(:pbjorklund))
    controller.stub(:twitter).and_return(FactoryGirl.build(:twitter_follower))
  end

  describe "GET 'followers'" do
    #Perhaps not optimal, this get's run every time
    before(:each) do
      VCR.use_cassette('twitter_controller/followers') do
        get 'followers'
      end
    end

    it "returns http success" do
      response.should be_success
    end
  end

  describe "GET 'following'" do
    #Perhaps not optimal, this get's run every time
    before(:each) do
      VCR.use_cassette('twitter_controller/following') do
        get 'following'
      end
    end

    it "returns http success" do
      response.should be_success
    end
  end

  describe "GET 'not_following_back'" do
    #Perhaps not optimal, this get's run every time
    before(:each) do
      VCR.use_cassette('twitter_controller/not_following_back') do
        get 'not_following_back'
      end
    end

    it "returns http success" do
      response.should be_success
    end
  end

  describe "POST 'unfollow'" do
    it "unfollows a user when given a nickname" do
      @request.env['HTTP_REFERER'] = '/followers'
      VCR.use_cassette('twitter_controller/unfollow') do
        post 'unfollow', id: "tweepsmanager"
      end
      response.should redirect_to followers_path
    end

    it "does not unfollow a user that does not exist" do
      @request.env['HTTP_REFERER'] = '/followers'
      VCR.use_cassette('twitter_controller/unfollow_doesnt_exist') do
        post 'unfollow', id: "jiofewijfeiowjfeowfjew"
      end
      flash[:error].should_not be_nil
      flash[:error].should have_content("not found, could not unfollow")
      response.should redirect_to followers_path
    end
  end

  describe "POST 'follow'" do
    before(:each) do
      @request.env['HTTP_REFERER'] = '/followers'
    end

    it "follows a user when given a nickname" do
      VCR.use_cassette('twitter_controller/follow') do
        post 'follow', id: "tweepsmanager"
      end
      flash[:notice].should_not be_nil
      response.should redirect_to followers_path
    end

    it "does not follow a user that does not exist" do
        VCR.use_cassette('twitter_controller/follow_doesnt_exist') do
        post 'follow', id: "jiofewijfeiowjfeowfjew"
      end
      flash[:error].should_not be_nil
      flash[:error].should have_content("not found, could not follow")
      response.should redirect_to followers_path
    end
  end
end
