require 'spec_helper'

describe TwitterController do

  before(:each) do
    controller.stub(:current_user).and_return(FactoryGirl.build(:pbjorklund))
    controller.stub(:twitter).and_return(mock_model("TwitterFollower", unfollow: true, follow: true))
  end

  describe "GET 'followers'" do
    it "should make sure that the user is signed in" do
      controller.should_receive(:signed_in?)
      get 'followers'
    end

    it "returns http success" do
      get 'followers'
      response.should be_success
    end
  end

  describe "GET 'following'" do
    it "returns http success" do
      get 'following'
      response.should be_success
    end
  end

  describe "GET 'not_following_back'" do
    it "returns http success" do
      get 'not_following_back'
      response.should be_success
    end
  end

  describe "POST 'unfollow'" do

    it "unfollows a user when given a nickname" do
      @request.env['HTTP_REFERER'] = '/followers'
      post 'unfollow', id: "existing_user"
      response.should redirect_to followers_path
    end

    it "does not unfollow a user that does not exist" do
      controller.send(:twitter).stub(:unfollow).and_raise(Twitter::Error::NotFound.new("", {}))
      controller.send(:twitter).should_receive(:unfollow).once
      @request.env['HTTP_REFERER'] = '/followers'
      post 'unfollow', id: "non_existing_user"

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
      post 'follow', id: "tweepsmanager"
      flash[:notice].should_not be_nil
      response.should redirect_to followers_path
    end

    it "does not follow a user that does not exist" do
      controller.send(:twitter).stub(:follow).and_raise(Twitter::Error::NotFound.new("", {}))
      post 'follow', id: "jiofewijfeiowjfeowfjew"
      flash[:error].should_not be_nil
      flash[:error].should have_content("not found, could not follow")
      response.should redirect_to followers_path
    end
  end
end

