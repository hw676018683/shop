class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  has_many :replies, dependent: :destroy
  belongs_to :reply

  validates :content, length: {minimum: 6, maximum: 50}

end
