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

    it "renders error partial on twitter exceptions with js response" do
      @twitter.stub(:get_follower_ids).and_raise(Twitter::Error::NotFound.new("Not found", {}))
      @twitter.stub(:get_api_status).and_return("ok")

      get 'followers', format: :js 
      assigns[:error].should_not be_blank
      response.should render_template("shared/error")
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
      @twitter.should_receive(:unfollow).once
      post 'unfollow', id: "existing_user", format: :js
      response.should be_success
    end

    it "renders the error screen when exceptions are caught" do
      @twitter.stub(:unfollow).and_raise(Twitter::Error::NotFound.new("Not found:", {}))
      @twitter.stub(:get_api_status).and_return("ok")

      post 'unfollow', id: "existing_user", format: :js
      assigns[:error].should_not be_blank
      response.should render_template("shared/error")
    end
  end

  describe "POST 'follow'" do
    it "follows a user when given a nickname" do
      @twitter.should_receive(:follow).once
      post 'follow', id: "existing_user", format: :js
      response.should be_success
    end

    it "renders the error screen when exceptions are caught" do
      @twitter.stub(:follow).and_raise(Twitter::Error::NotFound.new("Not found:", {}))
      @twitter.stub(:get_api_status).and_return("ok")

      post 'follow', id: "existing_user", format: :js
      assigns[:error].should_not be_blank
      response.should render_template("shared/error")
    end
  end
end

