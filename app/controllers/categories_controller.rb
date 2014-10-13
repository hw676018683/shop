class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.where(status: true).paginate(page: params[:page], per_page: 10)
    render 'show.json.jbuilder'
  end
end
