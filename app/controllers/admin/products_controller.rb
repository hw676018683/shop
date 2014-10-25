class Admin::ProductsController < ApplicationController

  before_action :owner_exist?

  def create 
    message = {}
    @properties = []
    @skucates = []
    @skulists = []
    price = []
    quantity = []
    flag1 = true
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
      cate = Skucate.new(name1: skucate['name1'], value1: skucate['value1'], name2: skucate['name2'], value2: skucate['value2'])
      list = Skulist.new(price: skucate['price'], quantity: skucate['quantity'])
      price << skucate['price'].to_i
      quantity << skucate['quantity'].to_i
      if cate.invalid? | list.invalid?
        flag2 = false
      else
        @skucates << cate
        @skulists << list
      end
    end
    if @product.valid? & flag1 & flag2
      @product.price = price.min
      @product.quantity = quantity.sum
      @product.save
      @skucates.each_index do |index|
        @skucates[index].product_id = @product.id
        @skucates[index].save
        @skulists[index].skucate_id = @skucates[index].id
        @skulists[index].save
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
    @product = Product.find(id: params[:id])
    if @product.update(product_params)
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
      @products = @owner.store.products.where(status: true).paginate(page: params[:page], per_page: 10)
    else
      @products = @owner.store.products.where(status: true).paginate(page: 1, per_page: 10)
    end
    render 'show.json.jbuilder'
  end


  def show_down_products
    @products = @owner.store.products.where(status: false)
    render 'show.json.jbuilder'
  end

  private


  def product_params
    params.permit(:name, :category_id, :main_img)
  end

end

