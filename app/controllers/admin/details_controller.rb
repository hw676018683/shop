class Admin::DetailsController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find_by(id: params[:product_id])
    @detai = @product.details.build(detail_params)
    if @detail.save
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def update
    message = {}
    @detail = Detail.find_by(id: params[:id])
    if @detail.update(detail_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def destroy
    message = {}
    Detail.find_by(id: params[:id]).destroy
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

  def detail_params
    params.permit(:img, :text)
  end
end
