class User < ActiveRecord::Base
  has_many :collecting_relationships, dependent: :destroy
  has_many :collecting_stores, through: :collecting_relationships, source: :store

  has_many :following_relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :following_products, through: :following_relationships, source: :followed

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  validates :password, length: { minimum: 6 }

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def collect! store
    self.collecting_relationships.create!(store_id: store.id)
  end

  def uncollect! store
    self.collecting_relationships.find_by(store_id: store.id).destroy
  end

  def collect? store
    self.collecting_relationships.find_by(store_id: store.id)
  end


  def follow! product
    self.following_relationships.create!(followed_id: product.id)
  end

  def unfollow! product
    self.following_relationships.find_by(followed_id: product.id).destroy
  end

  def follow? product
    self.following_relationships.find_by(followed_id: product.id)
  end

  

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
