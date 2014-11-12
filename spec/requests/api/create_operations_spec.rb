require 'rails_helper'

describe 'Create operation' do
  before :each do
    owner = Admin::Owner.first
    parameters = {
      email: owner.email,
      password: '123456'
    }
    post '/admin/signin',parameters
    json = JSON.parse(response.body)
    expect(json['code']).to eq 'success'
    @remember_token = json['remember_token']
    @owner_id = json['owner_id']
  end

  describe 'POST /admin/products/:product_id/imglists' do
    it 'should create a imglist' do
      expect{
        post "/admin/products/#{Product.first.id}/imglists", attributes_for(:imglist, remember_token: @remember_token)
      }.to change(Imglist, :count).by 1
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail when product isnot found' do
      post "/admin/products/-1/imglists", attributes_for(:imglist, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end

    it 'should fail when parameters is invalid' do
      post "/admin/products/#{Product.first.id}/imglists", attributes_for(:imglist, img: nil, remember_token: @remember_token)
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'POST /admin/products/:product_id/properties' do
    it 'should create a property' do
      expect{
        post "/admin/products/#{Product.first.id}/properties", attributes_for(:property, remember_token: @remember_token)
      }.to change(Property, :count).by 1
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail when parameters is invalid' do
      post "/admin/products/#{Product.first.id}/properties", attributes_for(:property, name: nil, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end

    it 'should fail when product isnot found' do
      post "/admin/products/-1/properties", attributes_for(:property, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'POST /admin/products/:product_id/skucates' do
    it 'should create a skucate' do
      product = create(:product)
      expect{
        post "/admin/products/#{product.id}/skucates", attributes_for(:skucate, price: 2000, remember_token: @remember_token)
      }.to change(Skucate, :count).by(1)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
      expect(assigns(:product).quantity).to eq 60
      expect(assigns(:product).price).to eq 2000
    end

    it 'should fail when parameters is invalid' do
      post "/admin/products/#{Product.first.id}/skucates", attributes_for(:skucate, name2: 'haha', remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end

    it 'should fail when product isnot found' do
      post "/admin/products/-1/skucates", attributes_for(:skucate, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'POST /admin/products/:product_id/details' do
    it 'should create a detail' do
      expect{
        post "/admin/products/#{Product.first.id}/details", attributes_for(:detail, remember_token: @remember_token)
      }.to change(Detail, :count).by 1
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail when product isnot found' do
      post "/admin/products/-1/details", attributes_for(:detail, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

end