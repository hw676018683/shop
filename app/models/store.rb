class Store < ActiveRecord::Base
  has_many :categories
  has_many :products
  has_many :carousels

  mount_uploader :background, StoreUploader
end
