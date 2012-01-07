class User < ActiveRecord::Base
  validates_presence_of :provider, :uid, :name
  def self.create_with_omniauth(auth)
    begin
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
    rescue NoMethodError
      nil
    end
  end
end
