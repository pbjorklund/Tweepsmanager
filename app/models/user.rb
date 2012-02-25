class User < ActiveRecord::Base
  validates_presence_of :name, :image_url, :nickname
  has_one :auth, dependent: :destroy

  def self.create_with_omniauth(auth)
    user = User.find_or_create_by_id(auth[:uid]) do |user|
      user.id        = auth[:uid]
    end
    user.update_attributes( {
      name: auth[:info][:name],
      image_url: auth[:info][:image],
      nickname: auth[:info][:nickname],
      bio: auth[:info][:description]
    } )

    user.auth = Auth.find_or_initialize_by_token_and_secret(auth[:credentials][:token], auth[:credentials][:secret])

    user.auth.update_attributes( {
      provider: "twitter",
      token: auth[:credentials][:token],
      secret: auth[:credentials][:secret]
    })

    user
  end
end
