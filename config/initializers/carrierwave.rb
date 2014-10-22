  CarrierWave.configure do |config|
    config.storage             = :qiniu
    config.qiniu_access_key    = "F1j4qLKjTkEY50oDlWpV5_j1FQgaufJP-zJ25NNc"
    config.qiniu_secret_key    = 'DtZJiyd1IUJX-e2N6Qtd1MfbMv_D7VpKVzGvbTyl'
    config.qiniu_bucket        = "shop-picture"
    config.qiniu_bucket_domain = "shop-picture.qiniudn.com"
    # config.qiniu_protocol      = 'https'
  end