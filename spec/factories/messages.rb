FactoryGirl.define do
  factory :message do
    association :user
    association :product
    factory :code_1 do
      code 1
    end
    factory :code_2 do
      code 2
    end
    factory :code_3 do
      code 3
    end
    factory :code_4 do
      code 4
      association :reply
    end
  end
end