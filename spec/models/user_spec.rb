require 'spec_helper'

describe User do

  describe "when created" do
    let(:user) { FactoryGirl.create(:pbjorklund) }
    subject { user }

    specify { subject.should be_valid }
    it "should require a name" do
      subject.name = nil
      subject.should be_invalid
    end

    it "should require a image_url" do
      subject.image_url = nil
      subject.should be_invalid
    end

    it "should require a nickname" do
      subject.nickname = nil
      subject.should be_invalid
    end
  end

  describe "when using omniauth" do
    before(:each) do
      @auth = {
        uid: "123456",
        :info => { name: "The Name", image: "http://fj.com/image.jpg", nickname: "pbjorklund", description: "rocking it" },
        :credentials => { token: "tokentoken", secret:"secretsecret" }
      }
    end

    let(:user) { User.create_with_omniauth(@auth) }

    subject { user }

    describe "#self.create_with_omniauth" do
      specify { lambda { subject }.should change(User, :count).by(1) }
      specify { lambda { subject }.should change(Auth, :count).by(1) }
      specify { subject.auth.token.should == "tokentoken" }

      it "updates a user when a new hash is sent" do
        @auth[:info][:description] = "New description"
        lambda { user }.should_not raise_error
        subject.bio.should == "New description"
      end

      it "updates the users auth when new credentials is set" do
        @auth[:credentials][:token] = "newtoken"
        subject.auth.token.should == "newtoken"
      end
    end
  end
end
