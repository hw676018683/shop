# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  Product.create([{name: '车1', category_id: 4, main_img: 's1.jpg', store_id: 1},
                 {name: '车2', category_id: 4, main_img: 's2.jpg', store_id: 1},
                 {name: '车3', category_id: 5, main_img: 's3.jpg', store_id: 1},
                 {name: '车4', category_id: 5, main_img: 's4.jpg', store_id: 1},
                 {name: '车5', category_id: 5, main_img: 's5.jpg', store_id: 1}, 
                 {name: '车6', category_id: 6, main_img: 's6.jpg', store_id: 1},
                 {name: '车7', category_id: 6, main_img: 's7.jpg', store_id: 1}
                 ])

