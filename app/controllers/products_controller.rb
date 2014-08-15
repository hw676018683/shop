class ProductsController < ApplicationController
  def index
    @products = Product.all
    prices = []
  end

  def  show 
    @prices = []
    @oldprices = []
    @quantity = 0
    @product = Product.find(params[:id])
    @product.skucates.each do |skucate|
      @prices << skucate.skulist.price
      @quantity += skucate.skulist.quantity
      if !skucate.skulist.oldprice.nil?
        @oldprices << skucate.skulist.oldprice
      end
    end
  end

  def new
    @product = Product.new
    @cates = Category.all
  end

  def create
    @product = Product.new(name: params[:name], category_id: params[:category_id])
    if @product.save
      @product.properties.create(name: params[:p_name1], value: params[:p_value1])

      redirect_to '/products/home'
    end
  end

  def show_detail
    @product = Product.find(params[:id])
    @skulist = @product.skucates.where(value1: params[:value1],value2: params[:value2])[0].skulist
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
