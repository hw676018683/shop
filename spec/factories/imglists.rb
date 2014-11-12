FactoryGirl.define do
  factory :imglist do
    product
    img Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/picture.jpg')))
  end

end