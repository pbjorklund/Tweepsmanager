FactoryGirl.define do
  factory :twitter_follower do
    #If you build it, it shall pass.
    #Build the user instead of saving it to the database since it can already exist
    initialize_with { TwitterFollower.new(FactoryGirl.build(:pbjorklund)) }
  end
end
