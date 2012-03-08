require 'spec_helper'

describe TwitterController do

  #TODO Review with Laust if time
  before(:each) do
    controller.stub(:current_user).and_return(FactoryGirl.build(:pbjorklund))
    @twitter = mock_model("TwitterFollower", unfollow: true, follow: true)
    controller.stub(:twitter).and_return(@twitter)
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
    subject do
      @request.env['HTTP_REFERER'] = '/followers'
      post 'unfollow', id: "existing_user"
    end

    it "unfollows a user when given a nickname" do
      @twitter.should_receive(:unfollow).once
      subject
      response.should redirect_to followers_path
    end

    it "does not unfollow a user that does not exist" do
      @twitter.stub(:unfollow).and_raise(Twitter::Error::NotFound.new("", {}))
      @twitter.should_receive(:unfollow).once
      subject
      flash[:error].should have_content("Not found:")
      response.should redirect_to followers_path
    end
  end

  describe "POST 'follow'" do
    subject do
      @request.env['HTTP_REFERER'] = '/followers'
      post 'follow', id: "tweepsmanager"
    end

    it "follows a user when given a nickname" do
      subject
      flash[:notice].should_not be_nil
      response.should redirect_to followers_path
    end

    it "does not follow a user that does not exist" do
      controller.send(:twitter).stub(:follow).and_raise(Twitter::Error::NotFound.new("", {}))
      subject

      flash[:error].should_not be_nil
      flash[:error].should have_content("Not found:")
      response.should redirect_to followers_path
    end
  end
end

