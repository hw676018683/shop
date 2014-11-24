class Admin::ProductsController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    return_hash = {}
    @properties = []
    @skucates = []
    @properties = Property.build_by_json(params[:property])
    return_hash = Product.build_product_skucates(product_params, params[:skucate], @owner.store.id)
    if  (@properties != false) & (return_hash != false)
      @product = return_hash[:product]
      @skucates = return_hash[:skucates] 
      @product.save
      @skucates.each do |skucate|
        skucate.product_id = @product.id
        skucate.save
      end
      @properties.each do |property|
        property.product_id = @product.id
        property.save
      end
      message[:code] = 'success'
      message[:product_id] = @product.id
    else
      message[:code] = 'failure'
      message[:error] = 'Validation failed'
    end
    render json: message
  end

  def update
    message = {}
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:error] = @product.errors
    end
    render json: message
  end

  def destroy
    message = {}
    Product.find(params[:id]).destroy
    message[:code] = 'success'
    render json: message
  end

  def drop_product
    message = {}
    @product = @owner.store.products.where(status: true).find(params[:id])
    @product.update_attribute('status', false)
    @product.send_message(2)
    message[:code] = 'success'
    render json: message
  end

  def pick_product
    message = {}
    @owner.store.products.where(status: false).find(params[:id]).update_attribute('status', true)
    message[:code] = 'success'
    render json: message
  end

  def show_up_products
    if params[:page]
      @products = @owner.store.products.where(status: true).order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
    else
      @products = @owner.store.products.where(status: true).order(updated_at: :desc).paginate(page: 1, per_page: 10)
    end
    render 'show.json.jbuilder'
  end


  def show_down_products
    @products = @owner.store.products.where(status: false).order(updated_at: :desc)
    render 'show.json.jbuilder'
  end

  private


  def product_params
    params.permit(:name, :category_id, :main_img)
  end

end

