class Auth < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :secret, :token
  validates_presence_of :secret, :token
end
