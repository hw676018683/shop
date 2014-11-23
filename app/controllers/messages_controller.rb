class MessagesController < ApplicationController

  before_action :user_exist?

  def index
    @messages = @user.messages.ordered.paginate(page: params[:page], per_page: 10)   
    render 'index.json.jbuilder'
    @messages.where(status: false).update_all(status: true, updated_at: Time.now)
  end

  def destroy
    message = {}
    @user.messages.find(params[:id]).destroy
    message['code'] = 'success'
    render json: message
  end

  def unreadmessages
    message = {}
    message[:number] = @user.messages.where(status: false).count
    render json: message
  end

end
