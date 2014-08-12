class ProductsController < ApplicationController
  def index
    @products = Product.all
    prices = []
  end

  def  show 
    @product = Product.find(params[:id])
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

  def home
    
  end
end
