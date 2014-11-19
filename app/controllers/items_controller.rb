class ItemsController < ApplicationController
   # skip_before_filter :verify_authenticity_token, only: :create 
  
  def create
    message = {}
    @item = Item.new_item(params)
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
    @item = Item.find_item(params)
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
    Item.find_item(params).destroy
    message[:code] = 'success'
    render json: message
  end

  def index
    @items = Item.find_items(params)
    render 'index.json.jbuilder'
  end

end
