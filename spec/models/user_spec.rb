require 'spec_helper'

describe User do

  def valid_attributes(attributes = {})
    {
      provider: ",twitter",
      uid: ",123456",
      name: ",Nelson Mandela",
      image_url: ",http://www.twitter.com/image.jpg", 
      nickname: "nelson_mandela"
    }.merge(attributes)
  end

  before(:each) do
    @user = User.new
  end

  require 'spec_helper'
  
  describe "New user'" do
    it "should be valid given valid attributes" do
      User.create(valid_attributes).should be_valid
    end
  end
end
