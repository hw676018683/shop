require 'rails_helper'

describe 'GET /products/:id' do
  it 'should display a product in detail' do
    product = Product.find_by(id: 1)
    get "/products/#{product.id}"
    json = JSON.parse(response.body)
    expect(json['name']).to eq product.name
    expect(json['quantity']).to eq product.quantity
    expect(json['price']).to eq product.price.to_s
    expect(json['property'][0]['name']).to eq product.properties.first.name
    expect(json['skucate'][0]['value1']).to eq product.skucates.first.value1
    expect(json['skucate'][0]['oldprice']).to eq product.skucates.first.oldprice.to_s
    expect(json['imglist'][0]['img']).to end_with product.imglists.first.img_url
  end
end 

describe 'GET /products/:product_id/comments' do
  it 'should display comments of a product' do
    product = Product.first
    get "/products/#{product.id}/comments", page: 1
    json = JSON.parse(response.body)
    expect(json.size).to eq 10
    expect(json[0]['user_id']).to eq 1
    expect(json[0]['content']).to eq product.comments.last.content
  end
end    