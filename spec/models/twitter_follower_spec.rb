require 'spec_helper'

describe TwitterFollower do
  before(:each) do
    User.delete_all
    user = FactoryGirl.create(:pbjorklund)
    @client = TwitterFollower.new(user)
  end

  def returns_not_empty_user_list?(method)
    VCR.use_cassette("twitterfollower/#{method}") do
      @client.send(method).count.should > 0
    end
  end

  def run_with_recording(method)
    VCR.use_cassette("twitterfollower/#{method}") do
      re = @client.send(method)
    end
  end

  describe "New twitterfollower" do
    it "requires a user parameter" do
      lambda { TwitterFollower.new }.should raise_error(ArgumentError)
    end

    it "should get created given a user" do
      lambda { TwitterFollower.new(FactoryGirl.create(:user)) }.should_not raise_error
      @client.should_not be_nil
    end
  end

  describe "#twitter" do
    it "should return a object" do
      @client.twitter.should_not be_nil
    end
  end

  describe "#get_followers" do
    it "should return a list of users" do
      returns_not_empty_user_list? :get_followers
    end

    it "contains more than 101 users" do
      run_with_recording(:get_followers).count.should > 100
    end
  end

  describe "#follow" do
    it "should follow a user" do
      VCR.use_cassette('twitterfollower/follow') do
        #TODO Interesting way of doing stuff, perhaps not useful
        followed_user = @client.follow("Tweepsmanager").instance_eval do
          self.should_not == nil
          screen_name.should == "Tweepsmanager"
        end
      end
    end
  end

  describe "#unfollow" do
    it "should unfollow a user" do
      VCR.use_cassette('twitterfollower/unfollow') do
        @client.unfollow("ladygaga").screen_name.should == "ladygaga"
      end
    end
  end
end
