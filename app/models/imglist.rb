class Imglist < ActiveRecord::Base
  belongs_to :product, touch: true

  mount_uploader :img, AvatarUploader

  validates :img, presence: true 
end
