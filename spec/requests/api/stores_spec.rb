require 'rails_helper'

describe 'GET /', type: :request do
  it 'should show store index page' do
    store = Store.first
    get "/"
    json = JSON.parse(response.body)
    expect(json['slogan']).to eq store.slogan
    expect(json['carousel'][0]['picture']).to end_with store.carousels.first.picture
    expect(json['category'][0]['name']).to eq store.categories.first.name
    expect(json['category'][0]['product'][0]['picture']).to end_with store.categories.first.products.first.main_img_url
  end
end