class Admin::ImglistsController < ApplicationController
  # before_action :test
  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find_by(id: params[:product_id])
    @product.details.create(img: params[:img])
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
end
