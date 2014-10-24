class Admin::PropertiesController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find_by(id: params[:product_id])
    @property = @product.properties.build(property_params)
    if @property.save
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def update
    message = {}
    @property = Property.find(id: params[:id])
    if @property.update(property_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def destroy
    message = {}
    Property.find(id: params[:id]).destroy
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

  def property_params
    params.permit(:name, :value)
  end

end
