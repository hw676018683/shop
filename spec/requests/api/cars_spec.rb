require 'rails_helper'

describe 'Shop car API:' do
  context 'when user signins' do
    before :each do 
      @user = create :user
      post '/signin', attributes_for(:user)
      json = JSON.parse(response.body)
      @remember_token = json['remember_token']
      @user_id = json['user_id']
    end

    describe 'POST /cars' do
      it 'should add a product into a car' do
        skucate = create(:skucate)
        parameters = {
          product_id: skucate.product_id,
          value1: skucate.value1,
          value2: skucate.value2,
          quantity: 3,
          remember_token: @remember_token
        }
        post '/cars', parameters
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end

    describe 'GET /cars' do
      it 'should display products added into the car' do 
        skulist = create(:skulist)
        create(:car, user_id: @user_id, skucate_id: skulist.skucate.id)
        create(:car, user_id: @user_id, skucate_id: skulist.skucate.id)
        get '/cars', remember_token: @remember_token
        json = JSON.parse(response.body)
        expect(json.size).to eq 2
        expect(json[0]['skucate']['value1']).to eq skulist.skucate.value1
      end
    end

    describe 'PUT /cars/:id' do
      it 'should modify a car' do
        car = create(:car, user_id: @user_id)
        put "/cars/#{car.id}", quantity: 4, remember_token: @remember_token
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end

    describe 'DELETE /cars/:id' do
      it 'should delete the product in car' do
        car = create(:car, user_id: @user_id)
        delete "/cars/#{car.id}",remember_token: @remember_token
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

    describe 'POST /cars' do
      it 'should add a product into a nosign_car' do
        skucate = create(:skucate)
        parameters = {
          product_id: skucate.product_id,
          value1: skucate.value1,
          value2: skucate.value2,
          quantity: 3,
          nosign_id: @nosign_id
        }
        post '/cars', parameters
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end

    describe 'GET /cars' do
      it 'should display products added into the nosign_car' do 
        skulist = create(:skulist)
        create(:nosign_car, nosign_id: @nosign_id, skucate_id: skulist.skucate.id)
        create(:nosign_car, nosign_id: @nosign_id, skucate_id: skulist.skucate.id)
        get '/cars', nosign_id: @nosign_id
        json = JSON.parse(response.body)
        expect(json.size).to eq 2
        expect(json[0]['skucate']['value1']).to eq skulist.skucate.value1
      end
    end

    describe 'PUT /cars/:id' do
      it 'should modify a nosign_car' do
        nosign_car = create(:nosign_car, nosign_id: @nosign_id)
        put "/cars/#{nosign_car.id}", quantity: 4, nosign_id: @nosign_id
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end

    describe 'DELETE /cars/:id' do
      it 'should delete the product in nosign_car' do
        nosign_car = create(:nosign_car, nosign_id: @nosign_id)
        delete "/cars/#{nosign_car.id}",nosign_id: @nosign_id
        json = JSON.parse(response.body)
        expect(json['code']).to eq 'success'
      end
    end
  end

end