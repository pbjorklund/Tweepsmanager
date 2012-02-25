class User < ActiveRecord::Base
  validates_presence_of :name, :image_url, :nickname
  has_one :auth

  def self.create_with_omniauth(auth)
    user = User.find_or_create_by_id(auth[:uid]) do |user|
      user.id        = auth[:uid]
      user.name      = auth[:info][:name]
      user.image_url = auth[:info][:image]
      user.nickname  = auth[:info][:nickname]
      user.bio       = auth[:info][:description]
      user.auth = Auth.find_or_create_by_token_and_secret(auth[:credentials][:token], auth[:credentials][:secret]) do |a|
        a.provider = "twitter"
        a.token    = auth[:credentials][:token]
        a.secret   = auth[:credentials][:secret]
      end
    end
  end
end
