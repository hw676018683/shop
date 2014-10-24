class Admin::SkucatesController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @product = product.find_by(id: params[:product_id])
    @skucate = @product.skucates.build(skucate_params)
    if @skucate.save
      @skucate.skulist.create!(skulist_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def update
    message = {}
    @skucate = Skucate.find_by(skucate_params)
    if @skucate.skulist.update(skulist_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def destroy
    message = {}
    Skucate.find_by(skucate_params).destroy
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

  def skucate_params
    params.permit(:value1, :name1, :name2, :value2)
  end

  def skulist_params
    params.permit(:price, :quantity)
  end

end
