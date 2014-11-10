class MessagesController < ApplicationController

  before_action :user_exist?

  def index
    @messages = @user.messages.order(created_at: :desc).paginate page: params[:page], per_page: 10    
    render 'index.json.jbuilder'
    @messages.where(status: false).update_all(status: true, updated_at: Time.now)
  end

  def destroy
    message = {}
    @message = Message.find_by(id: params[:id])
    if @message.in? @user.messages
      @message.destroy
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:error] = 'No permission'
    end
    render json: message
  end

  def unreadmessages
    message = {}
    message[:number] = @user.messages.where(status: false).count
    render json: message
  end

end
