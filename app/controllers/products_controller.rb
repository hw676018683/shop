class ProductsController < ApplicationController
  
  def  show 
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      message = {}
      message[:code] = 'failure'
      message[:message] = "Couldn't find Product with 'id'=#{params[:id]}"
      render json: message
    else
      render 'show.json.jbuilder'
    end
  end

  def search
    @products = Product.find_by_sql("select name,id from products where name like '#{params[:name]}%'")
    if @products.nil?
      result = Hash.new
      result[:id] = "not found"
      result[:message] = "product not found"
      render json: result
    else
      render 'search.json.jbuilder'
    end
  end
end
