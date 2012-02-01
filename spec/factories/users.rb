FactoryGirl.define do
  sequence :id do |n|
    "12345#{n}"
  end

  sequence :nickname do |n|
    "pbjorklund#{n}"
  end

  factory :user do
    id         { FactoryGirl.generate(:id) }
    name       "Patrik Bjorklund"
    bio        "Rocking and rolling"
    image_url  "http//www.twitter.com/image.jpg"
    nickname   { FactoryGirl.generate(:nickname) }
    auth
  end

  factory :pbjorklund, :class => User do
    id         123456
    name       "Patrik Bjorklund"
    bio        "Rocking and rolling"
    image_url  "http//www.twitter.com/image.jpg"
    nickname   "pbjorklund"
    auth
  end
end
