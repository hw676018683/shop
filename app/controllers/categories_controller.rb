class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.status_true.paginate(page: params[:page], per_page: 10)
    render 'show.json.jbuilder'
  end
end
