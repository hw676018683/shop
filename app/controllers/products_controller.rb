class ProductsController < ApplicationController
  
  def  show 
    @product = Product.find(params[:id])
    render 'show.json.jbuilder'
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
