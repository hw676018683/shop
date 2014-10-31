class Store < ActiveRecord::Base
  has_many :categories
  has_many :products
  has_many :carousels

  has_many :collecting_relationships, dependent: :destroy
  has_many :collectors, through: :collecting_relationships, source: :user


  has_many :messages

  mount_uploader :background, AvatarUploader

end
