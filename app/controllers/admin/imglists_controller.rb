class Admin::ImglistsController < ApplicationController
  
  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find(params[:product_id])
    last_order = @product.imglists.collect(&:order).max || 0
    @imglist = @product.imglists.build(img: params[:img], order: last_order+1)
    if @imglist.save
      message[:code] = 'success'
      message[:imglist_id] = @imglist.id
    else
      message[:code] = 'failure'
      message[:error] = @imglist.errors
    end
    render json: message
  end

  def update
    message = {}
    @imglist = Imglist.find(params[:id])
    if @imglist.update_attributes(img: params[:img])
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:error] = @imglist.errors
    end
    render json: message
  end

  def update_order
    message = {}
    order = params[:order].split(',')
    order.each_index do |x|
      Imglist.find_by(id: order[x]).update(order: x+1)
    end
    message[:code] = 'success'
    render json: message
  end

  def destroy
    message = {}
    Imglist.find(params[:id]).destroy
    message[:code] = 'success'
    render json: message
  end

end
