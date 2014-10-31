  CarrierWave.configure do |config|
    config.storage             = :qiniu
    config.qiniu_access_key    = "OQ2YwfbHq5l5CH5kCJtjBbKWqwLdZodbChEZJfCS"
    config.qiniu_secret_key    = "uosM6FgqfZv1GUgqWUkDBZAMJB831gyLsk7jB7nk"
    config.qiniu_bucket        = "shop-images"
    config.qiniu_bucket_domain = "shop-images.qiniudn.com"
    config.qiniu_bucket_private= false
    # config.qiniu_protocol      = 'https'
    # config.qiniu_expires_in          = 3600
  end