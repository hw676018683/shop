FactoryGirl.define do
  factory :skucate do
    sequence(:name1) { |n| "sku-#{n}" }
    sequence(:value1) { |n| "sku-#{n}" }
    sequence(:price) { |n| 3000+n }
    oldprice 4000
    quantity 30

    association :product
  end
end