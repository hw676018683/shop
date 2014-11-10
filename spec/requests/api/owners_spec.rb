require 'rails_helper'

describe 'Owner API:' do
  describe 'POST /admin/signin' do
    it 'should return a token when succeeding' do
      owner = Admin::Owner.first
      parameters = {
        email: owner.email,
        password: '123456'
      }
      post '/admin/signin',parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end
  end

  it 'should fail when validation failed' do
    owner = Admin::Owner.first
      parameters = {
        email: owner.email,
        password: '1234561'
      }
      post '/admin/signin',parameters
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'failure'
    end
end