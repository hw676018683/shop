namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_stores
    make_categories
    make_products
    make_details
    make_owner
  end 
end 

def make_stores
  Store.create!(name: '专属', owner_id: 1, background: '背景.jpg',
              slogan: '这是一个标语.')
  Carousel.create!(store_id: 1, picture: "s1.jpg")
  Carousel.create!(store_id: 1, picture: "s2.jpg")
  Carousel.create!(store_id: 1, picture: "s3.jpg")
  Carousel.create!(store_id: 1, picture: "s4.jpg")
end

def make_categories
  Category.create!(name: "奔驰", store_id: 1)
  Category.create!(name: "法拉利", store_id: 1)
  Category.create!(name: "奥迪", store_id: 1)
end

def make_products
  11.times do |n|
    name = "车-#{n+1}"
    Product.create!(name: name, category_id: 1, 
                  main_img: 's1.jpg',
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10)
  end
  11.times do |n|
    name = "车-#{n+21}"
    Product.create!(name: name, category_id: 2, 
                  main_img: 's2.jpg',
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10)
  end
  11.times do |n|
    name = "车-#{n+41}"
    Product.create!(name: name, category_id: 3, 
                  main_img: 's3.jpg',
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10)
  end
  3.times do |n|
    name = "车-down-#{n}"
    Product.create!(name: name, category_id: 1, 
                  main_img: 's1.jpg',
                  store_id: 1,
                  price: (n+1)*10000,
                  quantity: (n+1)*10,
                  status: false)
  end
end

def make_details
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
    4.times do |n|
      product.imglists.create!(img: "s#{n+3}.jpg")
    end
    2.times do |n|
      product.details.create!(img: "s#{n+4}.jpg", text:"这是一个介绍")
    end
  end

  def make_owner
    Admin::Owner.create(email: '110@qq.com', password: '123456')
  end
end

