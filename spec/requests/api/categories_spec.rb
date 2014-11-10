require 'rails_helper'

describe 'GET /categories/:id', type: :request do
  it 'should display products of a category' do 
    category = Category.find_by(id: 1)
    get "/categories/#{category.id}"
    json = JSON.parse(response.body)
    expect(json[0]['picture_url']).to end_with category.products.first.main_img_url
  end
end

describe 'Owner operates categories' do
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

  describe 'GET /admin/categories' do
    it 'should display all categories' do
      get 'admin/categories', remember_token: @remember_token
      json = JSON.parse(response.body)
      expect(json.size).to eq 3
      expect(json[0]['name']).to eq '奔驰' 
    end
  end

  describe 'POST /admin/categories' do
    it 'should add a category' do
      expect{
         post "/admin/categories", attributes_for(:category, remember_token: @remember_token)
      }.to change(Category, :count).by 1
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end
  end

  describe 'PUT /admin/categories/:id' do
    it 'should update a category' do
      category = create(:category)
      put "admin/categories/#{category.id}", attributes_for(:category, name: 'test', remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail when id isnot found' do 
      put "admin/categories/-1", attributes_for(:category, name: 'test', remember_token: @remember_token)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

end