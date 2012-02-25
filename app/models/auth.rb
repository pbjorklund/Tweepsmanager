class Auth < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :secret
  validates_presence_of :secret, :token
end
