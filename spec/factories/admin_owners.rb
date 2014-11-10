FactoryGirl.define do 
  factory :owner, class: 'Admin::Owner' do
    # sequence(:email) { |n| "xx-#{n}@qq.com" }
    email 'xx@qq.com'
    password 'asd110'
  end
end