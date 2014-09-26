class CarsController < ApplicationController
   # skip_before_filter :verify_authenticity_token, only: :create 
  
  def create
    message = {}
    if params[:nosign_id].nil?
      if !user_exist? 
        return 
      end
      skucate = Skucate.find_by(product_id: params[:product_id], value1: params[:value1], value2: params[:value2])
      user = User.find_by(remember_token: User.encrypt(params[:remember_token]))
      user.cars.create!(skucate_id: skucate.id, quantity: params[:quantity])
    else
      NosignCar.create(nosign_id: params[:nosign_id], skucate_id: skucate.id,
                       quantity: params[:quantity])
    end
    message[:code] = 'success'
    render json: message
  end

  def update
    message = {}
    if !params[:nosign_id].nil?
      @car = NosignCar.find_by(id: params[:id])
      @cars = NosignCar.where(nosign_id: params[:nosign_id])
    else
      if !user_exist? 
        return 
      end
      user = User.find_by(remember_token: User.encrypt(params[:remember_token]))
      @car = Car.find_by(id: params[:id])
      @cars = Car.where(user_id: user.id)
    end
    
    if @car.in? @cars
      @car.update(quantity: params[:quantity])
      message[:code] = 'success'
      render json: message
    else
      message[:code] = "failure"
      message[:message] = "Please modify your car!"
      render json: message, status: 403
    end
  end

  def destroy
    message = {}
    if !params[:nosign_id].nil?
      @car = NosignCar.find_by(id: params[:id])
      @cars = NosignCar.where(nosign_id: cookies[:nosign_id])
    else
      if !user_exist? 
        return 
      end
      user = User.find_by(remember_token: User.encrypt(params[:remember_token]))
      @car = Car.find_by(id: params[:id])
      @cars = Car.where(user_id: user.id)
    end
    
    if @car.in? @cars
      @car.destroy
      message[:code] = 'success'
      render json: message
    else
      message[:code] = "failure"
      message[:message] = "Please delete your car!"
      render json: message, status: 403
    end
  end

  def index
    if !params[:nosign_id].nil?
      @items = NosignCar.where(nosign_id: params[:nosign_id])
    else
      if !user_exist? 
        return 
      end
      user = User.find_by(remember_token: User.encrypt(params[:remember_token]))
      @items = Car.where('user_id',user.id)
    end
    render 'index.json.jbuilder'
  end

  private

  def user_exist?
    user = User.find_by(remember_token: User.encrypt(params[:remember_token]))
    if user.nil?
      message = {}
      message[:code] = 'failure'
      render json: message
      return false
    end
  end

end
