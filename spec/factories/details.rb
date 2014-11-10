FactoryGirl.define do
  factory :detail do 
    product
    img Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/picture.jpg')))
    sequence(:text) { |n| "introduction-#{n}" }
  end
end