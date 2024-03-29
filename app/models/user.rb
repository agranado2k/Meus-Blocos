class User < ActiveRecord::Base
  attr_accessible :name, :email, :uid
  has_many :authorizations
  has_many :my_blocos
  has_many :blocos, :through => :my_blocos
  validates :name, :email, :uid, :presence => true

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"], :access_token => auth_hash["credentials"]["token"]
    end
  end
end
