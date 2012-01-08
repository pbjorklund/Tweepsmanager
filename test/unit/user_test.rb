require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @auth = { }
    @auth['provider'] = 'twitter'
    @auth['uid'] = '12345'
    @auth['info'] = {}
    @auth['info']['name'] = 'Sir Nilson Mandela'
    @auth["info"]["image"] = ""
    @auth["info"]["nickname"] = "pbjorklund"
    @auth['credentials'] = {}
    @auth["credentials"]["token"] = ""
    @auth["credentials"]["secret"] = ""

    @bad_auth = {}
  end

  test "it should create a new user with valid auth" do
    assert_difference('User.count') do
      User.create_with_omniauth(@auth)
    end
  end

  test "find and update should update user" do
    user =  User.create_with_omniauth(@auth)
    @auth['info']['name'] = "11111"
    User.find_and_update(@auth)
    assert_equal User.all(:conditions => { name: "11111" }).count, 1
  end

  test "valid user should be valid" do
    assert users(:pbjorklund).valid?
  end
end
