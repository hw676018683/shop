class Admin::DetailsController < ApplicationController

  before_action :owner_exist?, only: [:create, :destroy]

  def create
    message = {}
    @product = Product.find_by(id: params[:product_id])
    @product.details.create(img: params[:img], text: params[:text])
    message[:code] = 'success'
    render json: message
  end

  private

  def owner_exist?
    @owner = Admin::Owner.find_by(remember_token: owner.encrypt(params[:remember_token]))
    if @owner.nil?
      message = {}
      message[:code] = 'failure'
      render json: message
    end
  end
end
