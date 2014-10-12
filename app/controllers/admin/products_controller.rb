class Admin::ProductsController < ApplicationController

  before_action :owner_exist?, only: [:create, :destroy]

  def create 
    message = {}
    @properties = []
    @skucates = []
    @skulists = []
    flag1 = true
    flag2 = true
    # owner = Admin::Owner.find_by(remember_token: owner.encrypt(params[:remember_token]))
    owner = Admin::Owner.first
    @product = Product.new(name: params[:name], category_id: params[:category_id], store_id: owner.store.id)
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
      if cate.invalid? | list.invalid?
        flag2 = false
      else
        @skucates << cate
        @skulists << list
      end
    end
    if @product.valid? & flag1 & flag2
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

