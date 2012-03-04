require 'spec_helper'

describe TwitterFollower do
  before :all do
    @user ||= FactoryGirl.build :pbjorklund, auth: FactoryGirl.build(:real_auth)
    @client ||= TwitterFollower.new(@user)
  end

  describe "New twitterfollower" do
    specify { lambda { TwitterFollower.new }.should raise_error ArgumentError }
    specify { lambda { TwitterFollower.new(FactoryGirl.build :user) }.should_not raise_error }
  end

  describe "#twitter" do
    specify { @client.twitter.should_not be_nil }
    specify { @client.twitter.should == @client.twitter }
  end

  describe "#get_follower_ids" do
    specify { run_with_recording_without_append(:get_follower_ids, "pbjorklund").count.should > 0 }
  end

  describe "#get_followers" do
    let(:ids) { run_with_recording_without_append :get_follower_ids, "pbjorklund" }

    context "with no params" do
      specify { run_with_recording_without_append(:get_followers_for_page, ids, 0).count.should > 0 }
    end
  end

  describe "#get_following" do
    specify { run_with_recording(:get_following).count.should > 0 }
  end

  describe "#get_not_following_back" do
    specify { run_with_recording(:get_not_following_back).count.should > 0 }
  end

  describe "#follow" do
    specify { run_with_recording(:follow, "ladygaga").screen_name.should == "ladygaga" } # Valid user
    specify { expect { run_with_recording(:follow, "lady_gaga") }.to raise_error } # Suspended user
    specify { expect { run_with_recording(:follow, "Tweepsmanager") }.to raise_error } # current_user
  end

  describe "#unfollow" do
    specify { run_with_recording(:unfollow, "ladygaga").screen_name.should == "ladygaga" } # Valid user
    
    #You can unfollow whoever you want as long as they exist
    specify { expect { run_with_recording(:unfollow, "lady_gaga") } .to_not raise_error } # Suspended user
    specify { expect { run_with_recording(:unfollow, "Tweepsmanager") }.to_not raise_error } # current_user

    specify { expect { run_with_recording(:unfollow, "j12ioewfjew22iof") }.to raise_error } # not existing user
  end

  #private
  describe "#get_follower_ids_from_twitter" do
    it "gets several batches from twitter when a user is following more than 5000 users" do
      run_with_recording(:get_ids_from_twitter, :follower_ids, "svartling").count.should > 5001
    end
  end

  private

  def run_with_recording method, *params
    VCR.use_cassette "twitterfollower/#{params.empty? ? method.to_s : method.to_s + "_for_" + params.join("-") }" do
      @client.send method, *params
    end
  end

  def run_with_recording_without_append method, *params
    VCR.use_cassette "twitterfollower/#{method.to_s}" do
      @client.send method, *params
    end
  end
end
