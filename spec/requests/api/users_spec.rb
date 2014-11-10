require 'rails_helper'

describe 'POST /signin' do
  before :each do
    create :user
  end 
  it 'should succeed with correct username and password' do
    post '/signin', attributes_for(:user)
    json = JSON.parse(response.body)
    expect(json['code']).to eq 'success'
  end

  it 'should fail with uncorrect username and password' do
    post '/signin', attributes_for(:user, password: 'xx')
    json = JSON.parse(response.body)
    expect(json['code']).to eq 'failure'
  end
end

describe 'POSt /users' do
  it 'should succeed with valid attributes' do 
    expect{post '/users', attributes_for(:user)}.to change(User, :count).by(1)
    json = JSON.parse(response.body)
    expect(json['code']).to eq 'success'
  end

  it 'should fail with invalid attributes' do
    post '/users', attributes_for(:user, phone: nil)
    json = JSON.parse(response.body)
    expect(json['code']).to eq 'failure' 
  end
end

describe 'User API:' do
  before :each do
    @user = create :user
    post '/signin', attributes_for(:user)
    json = JSON.parse(response.body)
    @remember_token = json['remember_token']
    @user_id = json['user_id']
  end

  describe 'GET /users/:id/collect' do
    it 'should collect a store' do
      parameters = {
        remember_token: @remember_token,
        store_id: Store.first.id
      }
      get "/users/#{@user_id}/collect", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail if user has been collected it' do
      @user.collect! Store.first
      parameters = {
        remember_token: @remember_token,
        store_id: Store.first.id
      }
      get "/users/#{@user_id}/collect", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'GET /users/:id/uncollect' do
    it 'should uncollect a store' do
      @user.collect! Store.first
      parameters = {
        remember_token: @remember_token,
        store_id: Store.first.id
      }
      get "/users/#{@user_id}/uncollect", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail if user donot collect it' do
      parameters = {
        remember_token: @remember_token,
        store_id: Store.first.id
      }
      get "/users/#{@user_id}/uncollect", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'GET /users/:id/follow' do
    it 'should follow a product' do
      parameters = {
        remember_token: @remember_token,
        product_id: Product.first.id 
      }
      get "/users/#{@user_id}/follow", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail if user has been followed it' do
      @user.follow! Product.first
      parameters = {
        remember_token: @remember_token,
        product_id: Product.first.id
      }
      get "/users/#{@user_id}/follow", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'GET /users/:id/unfollow' do
    it 'should unfollow a product' do
      @user.follow! Product.first
      parameters = {
        remember_token: @remember_token,
        product_id: Product.first.id 
      }
      get "/users/#{@user_id}/unfollow", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail if user donot follow it' do
      parameters = {
        remember_token: @remember_token,
        product_id: Product.first.id
      }
      get "/users/#{@user_id}/unfollow", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

  describe 'GET /users/:id/collecting' do
    it 'should show the collecting' do
      @user.collect! Store.first
      parameters = {
        remember_token: @remember_token
      }
      get "/users/#{@user_id}/collecting", parameters
      json = JSON.parse(response.body)
      expect(json[0]['name']).to eq Store.first.name
    end
  end

  describe 'GET /users/:id/following' do
    it 'should show the following' do
      @user.follow! Product.first
      parameters = {
        remember_token: @remember_token
      }
      get "/users/#{@user_id}/following", parameters
      json = JSON.parse(response.body)
      expect(json[0]['name']).to eq Product.first.name
    end
  end

  describe 'POST /products/:product_id/comments' do
    it 'should comment a product' do
      parameters = {
        remember_token: @remember_token,
        content: 'This is a comment.'
      }
      expect{post "/products/#{Product.first.id}/comments", parameters}.to change(Comment, :count).by(1)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end
  end

  describe 'DELETE /products/:product_id/comments/:id' do
    it 'should delete a comment' do
      parameters = {
        remember_token: @remember_token,
      }
      comment = create(:comment, user_id: @user.id, product_id: Product.first.id)
      delete "/products/#{Product.first.id}/comments/#{comment.id}", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail if the comment donot belong to user' do
      parameters = {
        remember_token: @remember_token,
      }
      comment = create(:comment, user_id: 20, product_id: Product.first.id)
      delete "/products/#{Product.first.id}/comments/#{comment.id}", parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

end

