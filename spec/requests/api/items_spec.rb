require 'rails_helper'

describe 'Shopping cart API:' do
  context 'when user signins' do
    before :each do 
      @user = create :user
      post '/signin', attributes_for(:user)
      json = JSON.parse(response.body)
      @remember_token = json['remember_token']
      @user_id = json['user_id']
    end

    describe 'POST /items' do
      it 'should add a product into a cart' do
        skucate = create(:skucate)
        parameters = {
          product_id: skucate.product_id,
          value1: skucate.value1,
          value2: skucate.value2,
          quantity: 3,
          remember_token: @remember_token
        }
        expect{
          post '/items', parameters
          }.to change(Item, :count).by 1
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end

    describe 'GET /items' do
      it 'should display products added into the cart' do 
        skucate = create(:skucate)
        create(:item, user_id: @user_id, skucate_id: skucate.id)
        create(:item, user_id: @user_id, skucate_id: skucate.id)
        get '/items', remember_token: @remember_token
        json = JSON.parse(response.body)
        expect(json.size).to eq 2
        expect(json[0]['skucate']['value1']).to eq skucate.value1
      end
    end

    describe 'PUT /items/:id' do
      it 'should modify a cart' do
        item = create(:item, user_id: @user_id)
        put "/items/#{item.id}", quantity: 4, remember_token: @remember_token
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end

      it 'should fail when anuthenticated' do
        item = create(:item, user_id: @user_id)
        put "/items/#{item.id}", quantity: 4, remember_token: 'this is test!!'
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'failure'
        expect(json['error']).to eq "Counldn't find the user"
      end
    end

    describe 'DELETE /items/:id' do
      it 'should delete the product in cart' do
        item = create(:item, user_id: @user_id)
        delete "/items/#{item.id}",remember_token: @remember_token
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end
  end

  context 'when user donot signin' do
    before :each do 
      get '/nosign_id'
      json = JSON.parse(response.body)
      @nosign_id = json['nosign_id']
    end

    describe 'POST /items' do
      it 'should add a product into a cart' do
        skucate = create(:skucate)
        parameters = {
          product_id: skucate.product_id,
          value1: skucate.value1,
          value2: skucate.value2,
          quantity: 3,
          nosign_id: @nosign_id
        }
        post '/items', parameters
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end

    describe 'GET /items' do
      it 'should display products added into the cart' do 
        skucate = create(:skucate)
        create(:item, nosign_id: @nosign_id, skucate_id: skucate.id)
        create(:item, nosign_id: @nosign_id, skucate_id: skucate.id)
        get '/items', nosign_id: @nosign_id
        json = JSON.parse(response.body)
        expect(json.size).to eq 2
        expect(json[0]['skucate']['value1']).to eq skucate.value1
      end
    end

    describe 'PUT /items/:id' do
      it 'should modify a cart' do
        item = create(:item, nosign_id: @nosign_id)
        put "/items/#{item.id}", quantity: 4, nosign_id: @nosign_id
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end

    describe 'DELETE /items/:id' do
      it 'should delete the product in cart' do
        item = create(:item, nosign_id: @nosign_id)
        delete "/items/#{item.id}",nosign_id: @nosign_id
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end
  end

end