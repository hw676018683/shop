# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#    cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Store.create!(name: '专属', owner_id: 1, slogan: '这是一个标语.')
  Category.create!(name: "奔驰", store_id: 1)
  Category.create!(name: "法拉利", store_id: 1)
  Category.create!(name: "奥迪", store_id: 1)

  Carousel.create!(store_id: 1, picture: 's1.jpg')
  Carousel.create!(store_id: 1, picture: 's2.jpg')
  Carousel.create!(store_id: 1, picture: 's3.jpg')
  Carousel.create!(store_id: 1, picture: 's4.jpg')
  11.times do |n|
    name = "车-#{n+1}"
    Product.create!(name: name, category_id: 1, 
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10)
  end
  2.times do |n|
    name = "车-#{n+20}"
    Product.create!(name: name, category_id: 2, 
              store_id: 1,
              price: (n+1)*10000,
              quantity: (n+1)*10)
  end
  2.times do |n|
    name = "车-#{n+40}"
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
  @product = Product.first
  3.times do |n|
    2.times do |m|
      @product.skucates.create!(name1: '颜色', value1: "颜色-#{n+1}",
                            name2: '大小', value2: "大小-#{m+1}")
    end
  end
  @product.skucates.each do |skucate|
    skucate.create_skulist!(price: @product.price+rand(100),
                            quantity: 30+skucate.id, oldprice: @product.price)
  end
  4.times do |n|
    @product.imglists.create!()
  end
  3.times do |n|
    @product.properties.create!(name: "属性-#{n+1}", value: "属性值-#{n+1}")
  end
  3.times do |n|
    Detail.create!(product_id: 1, text: "这是介绍-#{n+1}")
  end

  Admin::Owner.create(email: '110@qq.com', password: '123456')
  User.create!(name: 'Love Tristana', email: '111@qq.com', password: 'asd110', phone: '1234567890')
  11.times do |n|
    Comment.create!(user_id: 1, product_id: 1, content: "这是一个评论#{n+1}")
  end