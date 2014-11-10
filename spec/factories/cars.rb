FactoryGirl.define do 
  factory :car do
    quantity 3
    association :user
    association :skucate
  end

  factory :nosign_car do
    quantity 3
  end
end