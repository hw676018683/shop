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

  def destroy
    message = {}
    @comment = Comment.find_by(id: params[:id])
    if @user.comments.include? @comment
      @comment.destroy
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  def index
    @product = Product.find_by(id: params[:product_id])
    @comments = @product.comments.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render json: to_builder(@comments).target!
    
  end

  private

  def to_builder comments
    json = Jbuilder.new
    json.array! comments do |comment|
      show comment,json
    end
    json
  end

  def show comment,json
    json.name comment.user.name
    json.(comment, :id, :content)
    json.time comment.created_at.utc
    if comment.replies.any?
      json.reply do 
        json.array! comment.replies do |reply|
          json.(reply, :id, :content)
          json.time reply.created_at.utc
          if reply.comments.any?
            json.comment do  
              json.array! reply.comments do |x|
                show x,json
              end
            end
          end
        end
      end
    end
  end


end
