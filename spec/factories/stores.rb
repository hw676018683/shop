FactoryGirl.define do 
  factory :store do
    name 'xx'
    slogan 'yy'
    association :owner
  end
end