FactoryGirl.define do
  factory :property do
    sequence(:name) { |n| "property-name-#{n}" }
    sequence(:value) { |n| "property-value-#{n}" } 
    association :product
  end
end