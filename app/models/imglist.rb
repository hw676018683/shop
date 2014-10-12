class Imglist < ActiveRecord::Base
  belongs_to :product

  mount_uploader :img, AvatarUploader
end
