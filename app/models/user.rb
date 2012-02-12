class User < ActiveRecord::Base
  validates_presence_of :name, :image_url, :nickname
  has_one :auth
  has_many :relationships
  has_many :following, through: :relationships

  def self.create_with_omniauth(auth)
    if User.find_by_id(auth[:uid]) == nil
      user = create! do |user|
        user.id        = auth[:uid]
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

      user
    else
      user = find_and_update(auth)
    end
  end

  def refresh_followers
    twitter = TwitterFollower.new(self)
    already_following = self.followers.map {|u| u.id }
    twitter.get_followers(100, already_following).each do |follower|

      create_user_from_twitter_user(follower).follow(self)

    end
  end

  def refresh_following
    twitter = TwitterFollower.new(self)

    already_followers = self.following.map {|u| u.id }

    twitter.get_following(100, already_followers).each do |following|
      user = create_user_from_twitter_user(following)
      self.follow(user)
    end
  end

  def create_user_from_twitter_user(user)
      created_user = User.find_or_create_by_id(user.id) do |created_user|
        created_user.id         = user.id
        created_user.name       = user.name
        created_user.image_url  = user.profile_image_url
        created_user.nickname   = user.screen_name
        created_user.bio        = user.description
        created_user.last_tweet = "No last tweet"
      end

      if user.status != nil
        created_user.last_tweet = user.status.text
        created_user.save
      end

      created_user
  end

  def self.find_and_update(auth)
    user = User.find_by_id(auth[:uid])
    if user.nil?
      return nil
    else
      user.name        = auth[:info][:name]
      user.image_url   = auth[:info][:image]
      user.nickname    = auth[:info][:nickname]
      user.auth.token  = auth[:credentials][:token]
      user.auth.secret = auth[:credentials][:secret]
      user.save!
    end
    user
  end

  def follow(user)
    self.relationships.create(user_id: self, following_id: user.id)
  end

  def followers
    user_ids = Relationship.find_all_by_following_id(self.id)
    u = user_ids.map { |rel| rel.user }
  end

  def following
    user_ids = Relationship.find_all_by_user_id(self.id)
    u = user_ids.map { |rel| rel.following }
  end

  def following?(user)
    self.following.include?(user)
  end
end
