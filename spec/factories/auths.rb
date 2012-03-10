# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :token
  sequence :secret

  factory :auth do
    provider   "twitter"
    token      FactoryGirl.generate(:token)
    secret     FactoryGirl.generate(:secret)
  end

  factory :real_auth, class: Auth do
    provider   "twitter"
    token  APP_CONFIG['user_token']
    secret APP_CONFIG['user_secret']
  end
end
