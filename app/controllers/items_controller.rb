class ItemsController < ApplicationController
   # skip_before_filter :verify_authenticity_token, only: :create 
  
   before_action :set_item, only: [:update, :destroy]

  def create
    message = {}
    skucate = Skucate.find_by(skucate_params)
    if params[:nosign_id].present?
      @item = Item.new(nosign_id: params[:nosign_id], skucate_id: skucate.id, quantity: params[:quantity])   
    else
      user_exist?
      @item = @user.items.build(skucate_id: skucate.id, quantity: params[:quantity])
    end
    if @item.save
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:error] = @item.errors
    end
    render json: message
  end

  def update
    message = {}
    if @item.update_attributes(quantity: params[:quantity])
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:error] = @item.errors
    end
    render json: message
  end

  def destroy
    message = {}
    @item.destroy
    message[:code] = 'success'
    render json: message
  end

  def index
    if params[:nosign_id].present?
      @items = Item.where(nosign_id: params[:nosign_id])
    else
      user_exist?
      @items = Item.where(user_id: @user.id)
    end
    render 'index.json.jbuilder'
  end

  private

  def set_item
    if params[:nosign_id].present?
      @item = Item.where(nosign_id: params[:nosign_id]).find(params[:id])
    else
      user_exist?
      @item = Item.where(user_id: @user.id).find(params[:id])
    end
  end

  def user_exist?
    @user = User.find_by(remember_token: User.encrypt(params[:remember_token]))
    if @user.nil?
      raise AuthenticationFailed, "Counldn't find the user"
    end
  end

  def skucate_params
    params.permit(:product_id, :value1, :value2)    
  end

end
