class CommentsController < ApplicationController

  before_action :user_exist?, only: :create

  def create
    message ={}
    @comment = Comment.new(user_id: @user.id, product_id: params[:product_id], content: params[:content])
    if @comment.save
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:errors] = @comment.errors.full_messages.to_s
    end
    render json: message
  end

  def index
    @product = Product.find_by(id: params[:product_id])
    @comments = @product.comments.paginate(page: params[:page], per_page: 10)
    render 'index.json.jbuilder'
  end

end
