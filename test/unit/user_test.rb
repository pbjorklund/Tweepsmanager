require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @auth = { }
    @auth['provider'] = 'twitter'
    @auth['uid'] = '12345'
    @auth['info'] = {}
    @auth['info']['name'] = 'Sir Nilson Mandela'

    @bad_auth = {}
  end

  test "it should create a new user with valid auth" do
    assert_difference('User.count') do
      User.create_with_omniauth(@auth)
    end
  end

  test "it should not create a new user with invalid auth" do
    assert_no_difference('User.count') do
      User.create_with_omniauth(@bad_auth)
    end
  end


end
