class Admin::CategoriesController < ApplicationController

  before_action :owner_exist?

  def create
    message = {}
    @category = @owner.store.categories.build(category_params)
    if @category.save
      message[:code] = 'success'
      message[:category_id] = @category.id
    else
      message[:code] = 'failure'
      message[:error] = @category.errors
    end
    render json: message
  end

  def index
    @categories = @owner.store.categories
    render 'index.json.jbuilder'
  end

  def update
    message = {}
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:error] = @category.errors
    end
    render json: message
  end

  private


  def category_params
    params.permit(:name)
  end

end
