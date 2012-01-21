require 'spec_helper'

describe User do

  def valid_attributes(attributes = {})
    {
      provider: "twitter",
      uid: "123456",
      name: "Nelson Mandela",
      image_url: "http://www.twitter.com/image.jpg",
      nickname: "nelson_mandela",
      token: "token",
      secret: "secret"
    }.merge(attributes)
  end

  before(:each) do
    @user = User.create(valid_attributes)
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
