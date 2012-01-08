require 'test_helper'

class TwitterControllerTest < ActionController::TestCase

  def setup 
    @user = users(:pbjorklund)
    @request.session[:user_id] = @user.id
  end

  test "should get following" do
    get :following
    assert_response :success
    assert_not_nil assigns(:user)
    assert assigns(:user).nickname == @user.nickname
  end

  #test "should get followers" do
  #  get :followers
  #  assert_response :success
  #  assert_not_nil assigns(:user)
  #  assert assigns(:user).nickname == "pbjorklund"
  #end


  #test "should get friends" do
  #  get :friends
  #  assert_response :success
  #end

  #test "should get stalkers" do
  #  get :stalkers
  #  assert_response :success
  #end

  #test "should get only_following" do
  #  get :only_following
  #  assert_response :success
  #end

end
