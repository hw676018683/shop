  # CarrierWave.configure do |config|
  #   config.storage             = :qiniu
  #   config.qiniu_access_key    = "OQ2YwfbHq5l5CH5kCJtjBbKWqwLdZodbChEZJfCS"
  #   config.qiniu_secret_key    = "uosM6FgqfZv1GUgqWUkDBZAMJB831gyLsk7jB7nk"
  #   config.qiniu_bucket        = "shop-images"
  #   config.qiniu_bucket_domain = "shop-images.qiniudn.com"
  #   config.qiniu_bucket_private= false
  #   # config.qiniu_protocol      = 'https'
  #   # config.qiniu_expires_in          = 3600
  # end
if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  # make sure our uploader is auto-loaded
  AvatarUploader

  # use different dirs when testing
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end