require 'rails_helper'

describe 'Update operations' do
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

  describe 'PUT /admin/products/:id' do
    it 'should update a product'do
      product = create(:product)
      put "/admin/products/#{product.id}", attributes_for(:product, name: 'test', remember_token: @remember_token)
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail when id isnot found' do 
      put "admin/products/-1", attributes_for(:product, name: 'test', remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end

    it 'should fail when parameters is invalid' do
      product = create(:product)
      put "/admin/products/#{product.id}", attributes_for(:product, name: nil, remember_token: @remember_token)
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'PUT /admin/products/:product_id/imglists/:id' do
    it 'should update a imglist'do
      imglist = create(:imglist)
      put "/admin/products/#{imglist.product.id}/imglists/#{imglist.id}", attributes_for(:imglist, remember_token: @remember_token)
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail when id isnot found' do 
      imglist = create(:imglist)
      put "/admin/products/#{imglist.product.id}/imglists/-1", attributes_for(:imglist, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end

    # it 'should fail when parameters is invalid' do
    #   imglist = create(:imglist)
    #   parameters = {
    #     img: nil,
    #     remember_token: @remember_token
    #   }
    #   put "/admin/products/#{imglist.product.id}/imglists/#{imglist.id}", parameters
    #   json =JSON.parse(response.body)
    #   expect(json['code']).to eq 'failure'
    # end
  end

   describe 'PUT /admin/products/:product_id/details/:id' do
    it 'should update a detail'do
      detail = create(:detail)
      put "/admin/products/#{detail.product.id}/details/#{detail.id}", attributes_for(:detail, remember_token: @remember_token)
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail when id isnot found' do 
      detail = create(:detail)
      put "/admin/products/#{detail.product.id}/details/-1", attributes_for(:detail, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'PUT /admin/products/:product_id/properties/:id' do
    it 'should update a property'do
      property = create(:property)
      put "/admin/products/#{property.product.id}/properties/#{property.id}", attributes_for(:property, remember_token: @remember_token)
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail when id isnot found' do 
      property = create(:property)
      put "/admin/products/#{property.product.id}/properties/-1", attributes_for(:property, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end

    it 'should fail when parameters is invalid' do
      property = create(:property)
      put "/admin/products/#{property.product.id}/properties/#{property.id}", attributes_for(:property, name: nil, remember_token: @remember_token)
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'PUT /admin/products/:product_id/skucates/:id' do
    it 'should update a skucate'do
      user = User.first
      product = create(:product, price: 3000, quantity: 20)
      skucate = create(:skucate, product_id: product.id)
      skulist = create(:skulist, price: 3000, quantity: 20, skucate_id: skucate.id)
      user.follow! skulist.skucate.product
      expect{
        put "/admin/products/#{product.id}/skucates/#{skucate.id}", attributes_for(:skulist, price: 2000, quantity: 10, remember_token: @remember_token)
      }.to change(Message, :count).by 1
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'success'
      expect(assigns(:skucate).skulist.oldprice).to eq 3000
      expect(assigns(:skucate).product.quantity).to eq 10
      expect(assigns(:skucate).product.price).to eq 2000
    end

    it 'should fail when id isnot found' do 
      skucate = create(:skucate)
      put "/admin/products/#{skucate.product.id}/skucates/-1", attributes_for(:skucate, remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end

    it 'should fail when parameters is invalid' do
      skulist = create(:skulist)
      put "/admin/products/#{skulist.skucate.product.id}/skucates/#{skulist.skucate.id}", attributes_for(:skulist, price: nil, remember_token: @remember_token)
      json =JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'PUT /admin/products/:product_id/imglists/update_order' do
    it 'should update order of imglists' do
      product = create(:product)
      img1 = create(:imglist, product_id: product.id)
      img2 = create(:imglist, product_id: product.id)
      img3 = create(:imglist, product_id: product.id)
      parameters = {
        remember_token: @remember_token,
        order: "#{img3.id},#{img2.id},#{img1.id}"
      }
      put "/admin/products/#{product.id}/imglists/update_order", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
      expect(Product.find(product.id).imglists.collect(&:order)).to eq [3,2,1]
    end
  end


end