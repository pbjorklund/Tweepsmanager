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
      it "should require a name" do
        @user.name = nil
        @user.should be_invalid
      end

      it "should require a image_url" do
        @user.image_url = nil
        @user.should be_invalid
      end

      it "should require a nickname" do
        @user.nickname = nil
        @user.should be_invalid
      end
    end
  end

  describe "Omniauth" do
    before() do
      @auth = {
        uid: "123456",

        :info => {
        name: "The Name",
        image: "http://fj.com/image.jpg",
        nickname: "pbjorklund",
        description: "Consultant rocking it" },

        :credentials => {
        token: "tokentoken",
        secret: "secretsecret" }
      }
    end

    describe "#self.create_with_omniauth" do
      it "creates a new user given valid auth object" do
        User.delete_all
        lambda { User.create_with_omniauth(@auth) }.should change(User, :count).by(1)
      end

      it "creates a user.auth instance given a valid auth" do
        User.delete_all
        lambda { User.create_with_omniauth(@auth) }.should change(Auth, :count).by(1)
      end
    end

    describe "#self.find_and_update" do
      it "updates a user when a new hash is sent" do
        User.create_with_omniauth(@auth)

        @auth[:info][:description] = "New description"

        lambda { User.find_and_update(@auth) }.should_not raise_error

      end
    end
  end

  describe "relationships" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @follower = FactoryGirl.create(:user)
    end

    it "should respond to #relationships" do
      @user.should respond_to(:relationships)
    end

    it "creates a new relationship when given a user" do
      @user.follow(@follower)
    end

    it "returns a list of followers" do
      @user.followers.should_not be_nil
    end
  end
end
