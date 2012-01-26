FactoryGirl.define do
  factory :user do
    uid         "123456"
    name       "Patrik Bjorklund"
    bio        "Rocking and rolling"
    image_url  "http//www.twitter.com/image.jpg"
    nickname   "pbjorklund"
    auth
  end
end
