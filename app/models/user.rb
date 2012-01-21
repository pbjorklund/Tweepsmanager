class User < ActiveRecord::Base
  validates_presence_of :provider, :uid, :name, :token, :secret
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.name = auth[:info][:name]
      user.image_url = auth[:info][:image]
      user.nickname = auth[:info][:nickname]
      user.token = auth[:credentials][:token]
      user.secret = auth[:credentials][:secret]
    end
  end

  def self.find_and_update(auth)
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user.nil?
      return nil
    else
      user.name = auth["info"]["name"]
      user.image_url = auth["info"]["image"]
      user.nickname = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
      user.save!
    end
    user

  end
end
