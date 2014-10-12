class Admin::Owner < ActiveRecord::Base
  has_one :store

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX, message: '格式错误' }

  has_secure_password
  validates :password, length: { minimum: 6, message: '长度最小值为6' }

  def self.new_remember_token
    SecureRandom.urlsafe_base64
    # SecureRandom.hex(10)
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

end
