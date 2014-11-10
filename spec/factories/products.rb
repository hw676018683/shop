FactoryGirl.define do 
  factory :product do
    sequence(:name) { |n| "product-#{n}" }
    price 3000
    quantity 30
    main_img Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/picture.jpg')))
    association :category
    association :store
  end
end
