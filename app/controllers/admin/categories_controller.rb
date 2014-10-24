class Admin::CategoriesController < ApplicationController
  # before_action :test
  before_action :owner_exist?

  def create
    message = {}
    @category = @owner.store.categories.build(category_params)
    if @category.save
      message[:code] = 'success'
      message[:category_id] = @category.id
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def index
    @categories = @owner.store.categories
    render 'index.json.jbuilder'
  end

  def update
    message = {}
    @category = Category.find_by(id: params[:id])
    if @category.update(category_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  private

  def owner_exist?
    @owner = Admin::Owner.find_by(remember_token: Admin::Owner.encrypt(params[:remember_token]))
    if @owner.nil?
      message = {}
      message[:code] = 'failure'
      render json: message
    end
  end

  def test
    @owner = Admin::Owner.first
  end

  def category_params
    params.permit(:name)
  end

end
