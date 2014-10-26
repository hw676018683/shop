class Admin::RepliesController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @reply = Reply.new(owner_id: @owner.id, content: params[:content], comment_id: params[:comment_id])
    if @reply.save
      message[:code] = 'success'
      message[:reply_id] = @reply.id
    else
      message[:code] = 'failure'
      message[:error] = @reply.errors
    end
    render json: message
  end

  def destroy
    message = {}
    Reply.find_by(id: params[:id]).destroy
    message[:code] = 'success'
    render json: message
  end

end
