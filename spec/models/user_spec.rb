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
        User.create_with_omniauth(@auth)

        @auth[:info][:description] = "New description"

        lambda { User.find_and_update(@auth) }.should_not raise_error

      end
    end
  end

  context "no followers" do
    describe "#refresh_followers" do
      before(:each) do
        User.delete_all
        @user = FactoryGirl.create(:pbjorklund)
        VCR.use_cassette('user/refresh_followers') do
          @user.refresh_followers
        end
      end

      it "assigns followers to user" do
        @user.followers.count.should > 1
      end

      it "does not assign following" do
        @user.following.count.should == 0
      end

      it "does not create duplicate followers" do
        VCR.use_cassette('user/refresh_followers') do
          lambda { @user.refresh_followers }.should_not change(User, :count)
        end
      end
    end
  end

  context "with followers present" do
    before(:each) do
      User.delete_all
      @user = FactoryGirl.create(:pbjorklund)
      VCR.use_cassette('user/refresh_followers') do
        @user.refresh_followers
      end
    end

    describe "#refresh_followers" do
      it "should have followers" do
        @user.followers.count.should > 10
      end
    end
  end

  describe "#refresh_following" do
    it "assigns following to user" do
      User.delete_all
      @user = FactoryGirl.create(:pbjorklund)
      VCR.use_cassette('user/refresh_following') do
        lambda { @user.refresh_following }.should change(User, :count)
      end
    end
  end

  describe "relationships" do
    before(:each) do
      User.delete_all
      @user = FactoryGirl.create(:pbjorklund)
      @follower = FactoryGirl.create(:user)
    end

    it "should respond to #relationships" do
      @user.should respond_to(:relationships)
    end

    it "creates a new relationship when given a user", :focus do
      expect { @user.follow(@follower) }.to change(Relationship, :count).by(1)
    end

    it "does not create a duplicate relationship" do
      expect { @user.follow(@follower) }.to change(Relationship, :count).by(1)
      expect { @user.follow(@follower) }.to change(Relationship, :count).by(0)
      expect { @follower.follow(@user) }.to change(Relationship, :count).by(1)
      expect { @follower.follow(@user) }.to change(Relationship, :count).by(0)
    end
  end

  describe "#followers" do
    before(:each) do
      15.times do
        u = FactoryGirl.create(:user)
        u.follow(@user)
      end
    end

    it "should return a list of followers" do
      users = @user.followers
      users.count.should == 15
      users.first.name.should == "Mass User"
      users.first.following.count.should == 1
      users.first.following[0].name.should == "Patrik Bjorklund"
    end
  end

  describe "#following" do
    before(:each) do
      12.times do
        u = FactoryGirl.create(:user)
        @user.follow(u)
      end
    end

    it "returns a list of users" do
      users = @user.following
      users.count.should == 12
      users.first.name.should == "Mass User"
      users.first.followers.count.should == 1
      users.first.followers[0].name.should == "Patrik Bjorklund"
    end
  end

  describe "#following?" do
    before(:each) do
      User.delete_all
      @user = FactoryGirl.create(:pbjorklund)
      @following_user = FactoryGirl.create(:user)
      @following_user.follow(@user)
    end

    it "should return true when asking for a valid relationship", :focus do
      @following_user.following?(@user).should be_true
    end

    it "should return false when asking for a invalid relationship" do
      @user.following?(@user).should be_false
    end
  end
end
