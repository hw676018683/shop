class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :follow, :unfollow, :collect, :uncollect]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
    # logger.info ":#{@user.attributes.inspect}"
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to root_path
    else
      logger.info ":#{current_user.errors.inspect}"
      render 'edit'
    end
  end

  def follow
    @product = Product.find(params[:id])
    if !current_user.follow? @product
      current_user.follow! @product
      respond_to do |format|
        format.html { redirect_to product_path(@product) }
        format.js
      end
    else
      redirect_to product_path(@product) 
    end
  end

  def unfollow
    @product = Product.find(params[:id])
    current_user.unfollow! @product
    respond_to do |format|
      format.html { redirect_to product_path(@product) }
      format.js
    end  
  end

  def collect
    @store = Store.find(params[:id])
    if !current_user.collect?(@store)
      current_user.collect! @store
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def uncollect
    @store = Store.find(params[:id])
    current_user.uncollect! @store
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end



  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :province, :city, :address, :phone, :name)
  end

  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path
    end 
  end

end
