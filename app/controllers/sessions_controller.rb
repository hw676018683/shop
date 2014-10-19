class SessionsController < ApplicationController

  def create
    message = {}
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      remember_token = User.new_remember_token
      @user.update_attribute('remember_token', User.encrypt(remember_token))
      message[:code] = 'success'
      message[:user_id] = @user.id
      message[:remember_token] = remember_token
      add_to_cart(@user)
    else
      message[:code] = 'failure' 
    end
    render json: message
  end

  private

  def add_to_cart(user)
    items = []
    items = NosignCar.where(nosign_id: params[:nosign_id]).to_a
    if !items.nil?  
      items.each do |item|
        @user.cars.create(skucate_id: item.skucate_id,quantity: item.quantity)
        item.destroy
      end
    end
  end
end
