class UsersController < ApplicationController

  before_action :user_exist?, only: [:update, :follow, :unfollow, :collect, :uncollect]
  before_action :product_exist?, only: [:follow, :unfollow]
  before_action :store_exist?, only: [:collect, :uncollect]

  def create
    message = {}
    @user = User.new(user_params)
    if @user.save
      remember_token = User.new_remember_token
      @user.update(remember_token: User.encrypt(remember_token))
      message[:code] = 'success'
      message[:user_id] = @user.id
      message[:remember_token] = remember_token
    else
      message[:code] = 'failure'
      message[:errors] = @user.errors 
    end
    render json: message
  end

  def update
    user = User.find_by(id: params[:id])
    message = {}
    if user.update(email: params[:email])
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:errors] = user.errors
    end
    render json: message
  end

  def follow
    logger.info("xx")
    message = {}
    user = User.find(params[:id])
    @product = Product.find(params[:product_id])
    if !user.follow? @product
      user.follow! @product
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:message] = 'You have been followed' 
    end
    render json: message
  end

  def unfollow
    message = {}
    user = User.find(params[:id])
    @product = Product.find(params[:product_id])
    if user.follow? @product
      user.unfollow! @product
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:message] = 'You donot followed it' 
    end
    render json: message 
  end

  def collect
    message = {}
    user = User.find(params[:id])
    @store = Store.find(params[:store_id])
    if !user.collect? @store
      user.collect! @store
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:message] = 'You have been collected' 
    end
    render json: message
  end

  def uncollect
    message = {}
    user = User.find(params[:id])
    @store = Store.find(params[:store_id])
    if user.collect? @store
      user.uncollect! @store
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:message] = 'You donot collect it' 
    end
    render json: message
  end

  def nosign_id
    message = {}
    message[:nosign_id] = SecureRandom.hex(10)
    render json: nosign_id
  end



  private

  def user_params
    params.permit(:email, :password, :password_confirmation,
                                 :province, :city, :address, :phone, :name)
  end

  def user_exist?
    logger.info("#{params[:remember_token]}")
    user = User.find_by(remember_token: User.encrypt(params[:remember_token]), id: params[:id])
    if user.nil?
      message = {}
      message[:code] = 'failure'
      render json: message
    end
  end

  def product_exist?
    message = {}
    if !Product.find_by(id: params[:product_id])
      message[:code] = 'failure'
      message[:message] = "couldn't find Product with 'id'=#{params[:product_id]}"
      render json: message
    end
  end

   def store_exist?
    message = {}
    if !Store.find_by(id: params[:store_id])
      message[:code] = 'failure'
      message[:message] = "couldn't find Store with 'id'=#{params[:store_id]}"
      render json: message
    end
  end

end
