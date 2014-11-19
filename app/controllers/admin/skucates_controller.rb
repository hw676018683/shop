class Admin::SkucatesController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find(params[:product_id])
    @skucate = @product.skucates.build(skucate_params)
    if @skucate.save
      @product.quantity += params[:quantity].to_i
      if @product.price > params[:price].to_f
        @product.price = params[:price].to_f
      end
      @product.save
      message[:code] = 'success'
      message[:skucate_id] = @skucate.id
    else
      message[:code] = 'failure'
      message[:error] = @skucate.errors
    end
    render json: message
  end

  def update
    message = {}
    @skucate = Skucate.find(params[:id])
    old_quantity = @skucate.quantity 
    if @skucate.price <= params[:price].to_f
      if @skucate.update_attributes(price: params[:price], quantity: params[:quantity])
        @skucate.product.quantity += params[:quantity].to_i-old_quantity
        price = []
        @skucate.product.skucates.each do |skucate|
          price << skucate.price
        end
        @skucate.product.update_attribute('price',price.min)
        message[:code] = 'success'
      else
        message[:code] = 'failure'
        message[:error] = @skucate.errors
      end
    else
      oldprice = @skucate.price
       if @skucate.update_attributes(price: params[:price], quantity: params[:quantity], oldprice: oldprice)
        @skucate.product.send_message(3)
        @skucate.product.quantity += params[:quantity].to_i-old_quantity
        if @skucate.product.price > params[:price].to_f
          @skucate.product.update_attribute('price', params[:price])
        end
          @skucate
        message[:code] = 'success'
      else
        message[:code] = 'failure'
      end
    end
    render json: message
  end

  def destroy
    message = {}
    Skucate.find(params[:id]).destroy
    message[:code] = 'success'
    render json: message 
  end

  private

  def skucate_params
    params.permit(:value1, :name1, :name2, :value2, :price, :quantity)
  end

end
