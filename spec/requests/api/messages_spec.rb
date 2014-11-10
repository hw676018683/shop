require 'rails_helper'

describe 'Message API:' do 
  before :each do 
    @user = User.first
    parameters = {
      email: @user.email,
      password: 'asd110'
    }
    post '/signin', parameters
    json = JSON.parse(response.body)
    expect(json['code']).to eq 'success'
    @remember_token = json['remember_token']
    @user_id = json['user_id']
  end

  describe 'GET /messages' do
    it 'should display messages' do
      get '/messages', remember_token: @remember_token
      json = JSON.parse(response.body)
      expect(json.size).to eq 4
      expect(json[3]['store_name']).to eq @user.messages[0].store.name
      expect(json[2]['product_name']).to eq @user.messages[1].product.name
      expect(json[1]['product_name']).to eq @user.messages[2].product.name
      expect(json[0]['content']).to eq @user.messages[3].reply.content
      expect(@user.messages.where(status: false).count).to eq 0
    end
  end

  describe 'GET /messages/unreadmessages' do
    it 'should return a number' do
      get '/messages/unreadmessages',remember_token: @remember_token
      json = JSON.parse(response.body)
      expect(json['number']).to eq 3
    end
  end

  describe 'DELETE /messages/:id' do
    it 'should delele a message' do
      message = @user.messages.first
      delete "/messages/#{message.id}", remember_token: @remember_token
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end

    it 'should fail if id isnot found' do
      delete "/messages/-1", remember_token: @remember_token
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
  end

end