FactoryGirl.define do
  factory :user do
      provider   "twitter"
      uid        "123456"
      name       "Patrik Bjorklund"
      image_url  "http//www.twitter.com/image.jpg"
      nickname   "pbjorklund"
      token      "19505451-wwZ9Qt28u4BGUCxadxncM0oUXL1O8bralOfyWFTYV"
      secret     "PaFSjUhN6meYmyiDlKJmuXjMEHWng8UO6SYaZO52Y"
  end
end
