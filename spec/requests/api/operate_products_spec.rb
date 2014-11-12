require 'rails_helper'

describe 'Operation API:' do
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

  describe 'GET /admin/products/:id/drop_product' do
    it 'should pull a product off shelves' do
      user = create(:user) 
      product = Product.first
      user.follow! product
      expect{
        get "/admin/products/#{product.id}/drop_product",remember_token: @remember_token
        }.to change(Message,:count).by(1) 
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end
  end

  describe 'GET /admin/products/:id/pick_product' do
    it 'shoud put a product on shelves' do
      product = Product.where(status: false).first
      get "/admin/products/#{product.id}/pick_product",remember_token: @remember_token 
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success' 
    end
  end

  describe 'GET /admin/products/show_down_products' do
    it 'should display downed products' do
      get "/admin/products/show_down_products", remember_token: @remember_token
      json = JSON.parse(response.body)
      expect(json[0]['name']).to eq '车-down-2' 
    end
  end

  describe 'GET /admin/products/show_up_products' do
    it 'should display uped products' do
      parameters = {
        remember_token: @remember_token,
        page: 1
      }
      get "/admin/products/show_up_products", parameters
      json = JSON.parse(response.body)
      expect(json.size).to eq 10
      expect(json[0]['name']).to eq '车-1'
    end
  end

  describe 'DELETE /admin/products/:id' do
    it 'should delete a product' do 
      product = Product.first
      expect{
        delete "/admin/products/#{product.id}", remember_token: @remember_token
        }.to change(Product, :count).by(-1)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should delete its association-skucate' do
      product = Product.first
      expect{
        delete "/admin/products/#{product.id}", remember_token: @remember_token
        }.to change(Skucate, :count).by(-6)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should delete its association-imglist' do
      product = Product.first
      expect{
        delete "/admin/products/#{product.id}", remember_token: @remember_token
        }.to change(Imglist, :count).by(-4)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should delete its association-detail' do
      product = Product.first
      expect{
        delete "/admin/products/#{product.id}", remember_token: @remember_token
        }.to change(Detail, :count).by(-3)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should delete its association-property' do
      product = Product.first
      expect{
        delete "/admin/products/#{product.id}", remember_token: @remember_token
        }.to change(Property, :count).by(-3)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should delete its association-comment' do
      product = Product.first
      expect{
        delete "/admin/products/#{product.id}", remember_token: @remember_token
        }.to change(Comment, :count).by(-11)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end
  end

  describe 'Create products:' do
    describe 'first,POST /admin/products' do
      it 'should create a product and its skucate,property' do 
        user = User.first
        store = Store.first
        user.collect! store
        skucates = []
        properties = []
        product = build(:product, store_id: store.id)
        3.times do |n|
          skucate = build(:skucate, product_id: product.id, price: 3001+n)
          skucates << skucate
        end
        properties << build(:property, product_id: product.id)
        properties << build(:property, product_id: product.id)
        properties << build(:property, product_id: product.id)
        parameters = {
          name: product.name,
          category_id: product.category_id,
          main_img: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/picture.jpg'))),
          property: properties.to_json,
          skucate: skucates.to_json,
          remember_token: @remember_token
        }
        expect{
          post "/admin/products", parameters
          }.to change(Product, :count).by(1)
          .and(change(Message, :count).by(1))
          .and(change(Property, :count).by(3))
          .and(change(Skucate, :count).by(3))
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
        expect(assigns(:product).price).to eq 3001
        expect(assigns(:product).quantity).to eq 90
      end

      it 'should fail when parameters is invalid' do
      skucates = []
      properties = []
      product = build(:product, store_id: Store.first.id, name: nil)
      3.times do |n|
        skucate = build(:skucate, product_id: product.id, price: 3001+n)
        skucates << skucate
      end
      properties << build(:property, product_id: product.id)
      properties << build(:property, product_id: product.id)
      properties << build(:property, product_id: product.id)
      parameters = {
        name: product.name,
        category_id: product.category_id,
        main_img: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/picture.jpg'))),
        property: properties.to_json,
        skucate: skucates.to_json,
        remember_token: @remember_token
      }
      post "/admin/products", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
      end
    end

    describe 'second,POST /admin/products/:product_id/imglists' do
      it 'should create a img for a product' do
        expect{
          post "/admin/products/#{Product.first.id}/imglists", attributes_for(:imglist, remember_token: @remember_token)
        }.to change(Imglist, :count).by 1
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end 
    end

    describe 'third,POST /admin/products/:product_id/details' do 
      it 'should create a detail for a product' do
        expect{
          post "/admin/products/#{Product.first.id}/details", attributes_for(:detail, remember_token: @remember_token)
        }.to change(Detail, :count).by 1
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end
        
  end
end