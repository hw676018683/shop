class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/products/home'
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
    # logger.info ":#{@user.attributes.inspect}"
  end

  def update
    current_user.update_attributes(user_params)
    redirect_to '/products/home'
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
