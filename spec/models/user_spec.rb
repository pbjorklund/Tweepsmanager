require 'spec_helper'

describe User do

  context "creation / destruction" do
    subject { FactoryGirl.create(:pbjorklund) }

    describe "when created" do

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

    describe "when destroyed" do
      it "destroys the associated auth" do
        expect { subject.destroy }.to change(Auth, :count).by(0)
      end
    end
  end

  describe "when using omniauth" do
    let(:auth) { 
      { 
        uid: "123456", 
        :info => { 
          name: "The Name", 
          image: "http://fj.com/image.jpg",
          nickname: "pbjorklund",
          description:  "rocking it" 
        },
        :credentials => { 
          token: "tokentoken", 
          secret:"secretsecret" 
        } 
      } 
    } 

    let(:instance) { User.create_with_omniauth(auth) }

    describe "#self.create_with_omniauth" do
      context "when creating new user" do
        specify { expect { instance }.to change(User, :count).by(1) }
        specify { expect { instance }.to change(Auth, :count).by(1) }
      end

      context "when updating a user" do
        it "updates a user when a new hash is sent" do
          auth[:info][:description] = "New description"
          lambda { User.create_with_omniauth(auth) }.should_not raise_error
          User.first.bio.should == "New description"
        end

        it "updates the users auth when new credentials is set" do
          auth[:credentials][:token] = "newtoken"
          user = User.create_with_omniauth(auth)
          Auth.first.token.should == "newtoken"
        end
      end
    end
  end
end
