class Admin::ImglistsController < ApplicationController
  
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
    @imglist = Imglist.find_by(id: params[:id])
    if @imglist.nil?
      message[:code] = 'failure'
      message[:error] = 'id isnot fount'
      render json: message
      return
    end
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
    Imglist.find_by(id: params[:id]).destroy
    message[:code] = 'success'
    render json: message
  end

  private

  def test
    @owner = Admin::Owner.first
  end

end
