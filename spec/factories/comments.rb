FactoryGirl.define do 
  factory :comment do 
    sequence(:content) { |n| "this is a comment-#{n}" }
    association :product
    association :user
  end
end