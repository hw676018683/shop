class Admin::SkucatesController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find_by(id: params[:product_id])
    @skucate = @product.skucates.build(skucate_params)
    if @skucate.save
      @skucate.create_skulist!(skulist_params)
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
    if @skucate.skulist.price <= params[:price].to_i 
      if @skucate.skulist.update(skulist_params)
        message[:code] = 'success'
      else
        message[:code] = 'failure'
        message[:error] = @skucate.errors
      end
    else
      oldprice = @skucate.skulist.price
       if @skucate.skulist.update(price: params[:price], quantity: params[:quantity], oldprice: oldprice)
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
