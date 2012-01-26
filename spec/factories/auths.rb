# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auth do
    provider   "twitter"
    token      "19505451-wwZ9Qt28u4BGUCxadxncM0oUXL1O8bralOfyWFTYV"
    secret     "PaFSjUhN6meYmyiDlKJmuXjMEHWng8UO6SYaZO52Y"
  end
end
