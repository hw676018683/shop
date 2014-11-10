require 'rails_helper'

describe 'Reply API' do
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

  describe 'POST /admin/replies' do
    it 'should create a reply' do
      comment = create(:comment)
      expect {
        post "/admin/replies", attributes_for(:reply, comment_id: comment.id, remember_token: @remember_token)
      }.to change(Reply, :count).by(1).and(change(Message, :count).by(1))
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end
  end

  describe 'DELETE /admin/replies/:id' do
    it 'should delete a reply' do
      comment = create(:comment)
      reply = create(:reply, owner_id: @owner_id, comment: comment)
      expect {
        delete "/admin/replies/#{reply.id}", attributes_for(:reply, remember_token: @remember_token)
      }.to change(Reply, :count).by(-1)
      json = JSON.parse(response.body)
      expect(json['code']).to eq 'success'
    end
  end

end