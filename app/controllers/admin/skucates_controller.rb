class Admin::SkucatesController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find_by(id: params[:product_id])
    if @product.nil?
      message[:code] = 'failure'
      message[:error] = 'product_id isnot fount'
      render json: message
      return
    end
    @skucate = @product.skucates.build(skucate_params)
    if @skucate.save
      @skucate.create_skulist!(skulist_params)
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
    @skucate = Skucate.find_by(id: params[:id])
    if @skucate.nil?
      message[:code] = 'failure'
      message[:error] = 'id isnot fount'
      render json: message
      return
    end
    old_quantity = @skucate.skulist.quantity 
    if @skucate.skulist.price <= params[:price].to_f
      if @skucate.skulist.update_attributes(skulist_params)
        @skucate.product.quantity += params[:quantity].to_i-old_quantity
        price = []
        @skucate.product.skucates.each do |skucate|
          price << skucate.skulist.price
        end
        @skucate.product.update_attribute('price',price.min)
        message[:code] = 'success'
      else
        message[:code] = 'failure'
        message[:error] = @skucate.errors
      end
    else
      oldprice = @skucate.skulist.price
       if @skucate.skulist.update_attributes(price: params[:price], quantity: params[:quantity], oldprice: oldprice)
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
    Skucate.find_by(id: params[:id]).destroy
    message[:code] = 'success'
    render json: message 
  end

  private

  def skucate_params
    params.permit(:value1, :name1, :name2, :value2)
  end

  def skulist_params
    params.permit(:price, :quantity)
  end

end
