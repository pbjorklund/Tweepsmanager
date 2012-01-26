require 'spec_helper'

describe SessionsController do
  before(:each) do
    controller.stub!(:create_user).and_return FactoryGirl.create(:user)
  end

  describe "POST 'create'" do
    before(:each) do
      post :create
    end
    it "should return http success" do
      response.should redirect_to(root_url)
    end

    it "should set the session to the user id" do
      session[:user_id].should_not be_nil
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      delete 'destroy'
    end

    it "deletes the session user_id" do
      session[:user_id].should be_nil
    end

    it "redirects to root" do
      response.should redirect_to(root_url)
    end
  end
end
