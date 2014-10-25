class Admin::DetailsController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find_by(id: params[:product_id])
    @detail = @product.details.build(detail_params)
    if @detail.save
      message[:code] = 'success'
      message[:detail_id] = @detail.id
    else
      message[:code] = 'failure'
      message[:error] = @detail.errors
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
      message[:error] = @detail.errors
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

  def detail_params
    params.permit(:img, :text)
  end
end
