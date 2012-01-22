require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "New user'" do
    it "should be valid given valid attributes" do
      @user.should be_valid
    end

    context "when created" do

      it "should require a provider" do
        @user.provider = nil
        @user.should be_invalid
      end

      it "should require a uid" do
        @user.uid = nil
        @user.should be_invalid
      end

      it "should require a name" do
        @user.name = nil
        @user.should be_invalid
      end

      it "should require a token" do
        @user.token = nil
        @user.should be_invalid
      end

      it "should require a secret" do
        @user.token = nil
        @user.should be_invalid
      end
    end
  end
end
