class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :content, length: {minimum: 6, maximum: 50}
end
