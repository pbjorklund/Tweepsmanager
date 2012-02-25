require 'spec_helper'

describe Auth do
  let(:auth) { Auth.new(secret: "Secret", token: "Token") }
  specify { auth.should be_valid }

  it "isn't valid wihtout a token" do
    auth.token = nil
    auth.should_not be_valid
  end

  it "isn't valid without a secret" do
    auth.secret = nil
    auth.should_not be_valid
  end

  it "should not allow duplicate secrets" do
    expect { 2.times { Auth.create(secret: auth.secret, token: "token" ) } }.to change(Auth, :count).by(1)
  end
end
