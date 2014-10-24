class Admin::ImglistsController < ApplicationController
  # before_action :test
  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find_by(id: params[:product_id])
    @imglist = @product.imglists.build(imglist_params)
    if @imglist.save
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def update
    message = {}
    @imglist = Imglist.find_by(id: params[:id])
    if @imglist.update(imglist_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def destroy
    message = {}
    Imglist.find_by(id: params[:id]).destroy
    message[:code] = 'success'
    render json: message
  end

  private

  def owner_exist?
    @owner = Admin::Owner.find_by(remember_token: Admin::Owner.encrypt(params[:remember_token]))
    if @owner.nil?
      message = {}
      message[:code] = 'failure'
      render json: message
    end
  end

  def test
    @owner = Admin::Owner.first
  end

  def imglist_params
    params.permit(:img)
  end
end
