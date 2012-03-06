FactoryGirl.define do
  sequence :id do |n|
    "12345#{n}"
  end

  sequence :nickname do |n|
    "pbjorklund#{n}"
  end

  sequence :auth_secret
  sequence :auth_token

  factory :user do
    id         { FactoryGirl.generate(:id) }
    name       "Mass User"
    bio        "Rocking and rolling"
    image_url  "http//www.twitter.com/image.jpg"
    nickname   { FactoryGirl.generate(:nickname) }
    association :auth, secret: FactoryGirl.generate(:auth_secret), token: FactoryGirl.generate(:auth_token)
  end

  factory :pbjorklund, :class => User do
    id         19505451 
    name       "Patrik Bjorklund"
    bio        "Rocking and rolling"
    image_url  "http//www.twitter.com/image.jpg"
    nickname   "pbjorklund"
    association :auth, secret: FactoryGirl.generate(:auth_secret), token: FactoryGirl.generate(:auth_token)
  end
end
