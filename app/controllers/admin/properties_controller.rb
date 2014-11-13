class Admin::PropertiesController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @product = Product.find(params[:product_id])
    @property = @product.properties.build(property_params)
    if @property.save
      message[:code] = 'success'
      message[:property_id] = @property.id
    else
      message[:code] = 'failure'
      message[:error] = @property.errors
    end
    render json: message
  end

  def update
    message = {}
    @property = Property.find(params[:id])
    if @property.update_attributes(property_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:error] = @property.errors
    end
    render json: message
  end

  def destroy
    message = {}
    Property.find(params[:id]).destroy
    message[:code] = 'success'
    render json: message
  end

  private


  def property_params
    params.permit(:name, :value)
  end

end
