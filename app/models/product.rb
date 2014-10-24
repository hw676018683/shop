class Product < ActiveRecord::Base
  belongs_to :store, touch: true
  belongs_to :category, touch: true

  has_many :details, dependent: :destroy
  has_many :skucates, dependent: :destroy
  has_many :properties, dependent: :destroy
  has_many :imglists, dependent: :destroy

  has_many :comments

  validates :name, presence: true
  validates :category_id, presence: true

  mount_uploader :main_img, AvatarUploader
end
