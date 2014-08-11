class ProductsController < ApplicationController
  def index
    @products = Product.all
    prices = []
  end

  def  show 
    @product = Product.find(params[:id])
  end
end
