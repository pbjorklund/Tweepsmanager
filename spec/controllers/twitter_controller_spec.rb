require 'spec_helper'

describe TwitterController do

  before(:each) do
    controller.stub(:current_user).and_return( User.create(
      provider:   "twitter",
      uid:        "123456",
      name:       "Patrik Bjorklund",
      image_url:  "http://www.twitter.com/image.jpg",
      nickname:   "pbjorklund",
      token:      "19505451-wwZ9Qt28u4BGUCxadxncM0oUXL1O8bralOfyWFTYV",
      secret:     "PaFSjUhN6meYmyiDlKJmuXjMEHWng8UO6SYaZO52Y"
    ))
  end

  before(:each) do
    VCR.use_cassette('following') do
      visit "/auth/twitter"
    end
  end


  describe "GET 'following'" do
    it "returns http success" do
      VCR.use_cassette('following') do
        get 'following'
      end
      response.should be_success
    end
  end

  describe "GET 'followers'" do
    it "returns http success" do
      VCR.use_cassette('followers') do
        get 'followers'
      end
      response.should be_success
    end
  end

  describe "GET 'friends'" do
    it "returns http success" do
      VCR.use_cassette('friends') do
        get 'friends'
      end
      response.should be_success
    end
  end

  describe "GET 'stalkers'" do
    it "returns http success" do
      VCR.use_cassette('stalkers') do
        get 'stalkers'
      end
      response.should be_success
    end
  end

  describe "GET 'only_following'" do
    it "returns http success" do
      VCR.use_cassette('only_following') do
        get 'only_following'
      end
      response.should be_success
    end
  end

  describe "POST 'tweet'" do
    it "returns http success" do
      @request.env['HTTP_REFERER'] = '/twitter/followers'
      VCR.use_cassette('tweet') do
        post 'tweet', tweet: "Lets see if VCR is set up correctly, if not I apologize for the upcoming spam ;)"
      end
      response.should redirect_to twitter_followers_path
    end
  end
end
