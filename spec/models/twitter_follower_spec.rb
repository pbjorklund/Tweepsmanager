require 'spec_helper'

describe TwitterFollower do
  describe "New twitterfollower" do
    it "requires a user parameter" do
      lambda { TwitterFollower.new }.should raise_error(ArgumentError)
    end
  end


end
