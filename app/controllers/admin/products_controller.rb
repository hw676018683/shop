class Admin::ProductsController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @properties = []
    @skucates = []
    price = []
    quantity = []
    #flag1: property验证是否通过
    flag1 = true 
    #flag2: skucate验证是否通过
    flag2 = true
    @product = @owner.store.products.build(product_params)
    properties = JSON.parse(params[:property])
    properties.each do |property|
      if Property.new(property).invalid?
        flag1 = false
      else 
        @properties << Property.new(property)
      end 
    end
    skucates = JSON.parse(params[:skucate])
    skucates.each do |skucate|
      cate = Skucate.new(skucate)
      price << skucate['price'].to_i
      quantity << skucate['quantity'].to_i
      if cate.invalid?
        flag2 = false
      else
        @skucates << cate
      end
    end
    if @product.valid? & flag1 & flag2
      @product.price = price.min
      @product.quantity = quantity.sum
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
    end
    render json: message
  end

  def update
    message = {}
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      message[:code] = 'failure'
      message[:error] = 'id isnot fount'
      render json: message
      return
    end
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
    Product.find_by(id: params[:id]).destroy
    message[:code] = 'success'
    render json: message
  end

  def drop_product
    message = {}
    @product = Product.find_by(id: params[:id])
    if @owner.store.products.where(status: true).include? @product
      @product.update_attribute('status', false)
      @product.send_message(2)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:errors] = 'No permission to drop or has been dropped'
    end
    render json: message
  end

  def pick_product
    message = {}
    @product = Product.find_by(id: params[:id])
    if @owner.store.products.where(status: false).include? @product
      @product.update_attribute('status', true)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:errors] = 'No permission to do or has been done'
    end
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

