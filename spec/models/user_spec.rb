require 'spec_helper'

describe User do
  before(:each) do
    User.delete_all
    @user = FactoryGirl.create(:pbjorklund)
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
        Auth.delete_all
        User.delete_all
        lambda { User.create_with_omniauth(@auth) }.should change(User, :count).by(1)
      end

      it "creates a user.auth instance given a valid auth" do
        Auth.delete_all
        User.delete_all
        lambda { User.create_with_omniauth(@auth) }.should change(Auth, :count).by(1)
      end
    end

    describe "#self.find_and_update" do
      it "updates a user when a new hash is sent" do
        user = User.create_with_omniauth(@auth)
        @auth[:info][:description] = "New description"
        lambda { updated_user = User.find_and_update(@auth) }.should_not raise_error
      end

      it "updates the users auth when new credentials is set" do
        user = User.create_with_omniauth(@auth)
        @auth[:credentials][:token] = "New"
        updated_user = User.find_and_update(@auth)
        user.auth.token.should_not == updated_user.auth.token

      end
    end
  end
end
