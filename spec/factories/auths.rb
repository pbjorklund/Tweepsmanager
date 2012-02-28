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
    token  "458298205-Pm0TQtBrKOI2aHOT0AXKQEP5JZzyWngSmNunXHzc"
    secret "CSPVizi0vuf5pFsGbdpYG48SImVV3WYM45ZG0kSeYJE"
  end
end
