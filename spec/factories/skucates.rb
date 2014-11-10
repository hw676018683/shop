FactoryGirl.define do
  factory :skucate do
    sequence(:name1) { |n| "sku-#{n}" }
    sequence(:value1) { |n| "sku-#{n}" }
    association :product
  end
  factory :skulist do
    sequence(:price) { |n| 3000+n }
    oldprice 4000
    quantity 30
    association :skucate
  end
end