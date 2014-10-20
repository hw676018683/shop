namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_stores
    make_categories
    make_products
    make_details
    make_owner
    make_user
  end 
end 

def make_stores
  uploader = AvatarUploader.new
  file = Dir["public/public/upload/background*.jpg"].first
  uploader.store! File.open(File.expand_path(file)) 
  Store.create!(name: '专属', owner_id: 1,
              slogan: '这是一个标语.',
              background: uploader)
  4.times do |n|
    Carousel.create!(store_id: 1, picture: "s#{n+1}.jpg")
  end
end

def make_categories
  Category.create!(name: "奔驰", store_id: 1)
  Category.create!(name: "法拉利", store_id: 1)
  Category.create!(name: "奥迪", store_id: 1)
end

def make_products
  uploader = AvatarUploader.new
  11.times do |n|
    name = "车-#{n+1}"
    pro = Product.create!(name: name, category_id: 1, 
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10)
  end
  11.times do |n|
    name = "车-#{n+21}"
    Product.create!(name: name, category_id: 2, 
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10)
  end
  11.times do |n|
    name = "车-#{n+41}"
    Product.create!(name: name, category_id: 3, 
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10)
  end
  3.times do |n|
    name = "车-down-#{n}"
    Product.create!(name: name, category_id: 1, 
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10,
                  status: false)
  end
end

def make_details
  uploader = AvatarUploader.new
  @products = Product.all
  @products.each do |product|
    3.times do |n|
      2.times do |m|
        product.skucates.create!(name1: '颜色', value1: "颜色-#{n+1}",
                              name2: '大小', value2: "大小-#{m+1}")
      end
    end
    product.skucates.each do |skucate|
      skucate.create_skulist!(price: product.price,
                            quantity: 30+skucate.id, oldprice: product.price)
    end
    3.times do |n|
      product.properties.create!(name: "属性-#{n+1}", value: "属性值-#{n+1}")
    end
    # 3.times do |n|
    #   file = Dir["public/public/upload/s#{n+1}*.jpg"].first
    #   uploader.store! File.open(File.expand_path(file)) 
    #   product.imglists.create!(img: uploader)
    # end
    # 1.times do |n|
    #   file = Dir["public/public/upload/s#{n+4}*.jpg"].first
    #   uploader.store! File.open(File.expand_path(file)) 
    #   product.details.create!(img: uploader, text:"这是一个介绍")
    # end
  end

  def make_owner
    Admin::Owner.create(email: '110@qq.com', password: '123456')
  end

  def make_user
    User.create!(name: 'Love Tristana', email: '111@qq.com', password: 'asd110', phone: '1234567890')
  end

  def make_comments
    10.times do |n|
      Comment.create!(user_id: 1, product_id: n+1, content: '沙发沙发沙发')
    end
  end

end

