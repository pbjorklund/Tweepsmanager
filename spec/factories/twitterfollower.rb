FactoryGirl.define do
  factory :twitter_follower do

    initialize_with { TwitterFollower.new(FactoryGirl.create(:user)) }
  end
end
