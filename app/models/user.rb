class User < ActiveRecord::Base
  validates_presence_of :name, :image_url, :nickname
  has_one :auth
  has_many :followers, through: :relationships
  def self.create_with_omniauth(auth)
    if User.find_by_uid(auth[:uid]) == nil
      user = create! do |user|
        user.uid       = auth[:uid]
        user.name      = auth[:info][:name]
        user.image_url = auth[:info][:image]
        user.nickname  = auth[:info][:nickname]
        user.bio       = auth[:info][:description]
      end

      user.auth = Auth.create! do |a|
        a.provider = "twitter"
        a.token = auth[:credentials][:token]
        a.secret = auth[:credentials][:secret]
      end
    else
      find_and_update(auth)
    end

  end

  def self.find_and_update(auth)
    user = User.find_by_uid(auth[:uid])
    if user.nil?
      return nil
    else
      user.name      = auth[:info][:name]
      user.image_url = auth[:info][:image]
      user.nickname  = auth[:info][:nickname]
      user.auth.token     = auth[:credentials][:token]
      user.auth.secret    = auth[:credentials][:secret]
      user.save!
    end
    user
  end

end
