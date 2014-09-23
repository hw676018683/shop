class CarsController < ApplicationController
   # skip_before_filter :verify_authenticity_token, only: :create 
  
  def create
    skucate = Skucate.find_by(value1: params[:value1], value2: params[:value2])
    if current_user.nil?
      nosign_id = cookies[:nosign_id]
      NosignCar.create(nosign_id: nosign_id, skucate_id: skucate.id,
                       quantity: params[:quantity])
    else
      current_user.cars.create(skucate_id: skucate.id, quantity: params[:quantity])
    end
    redirect_to skucate.product
  end

  def update
    if current_user.nil?
      @car = NosignCar.find(params[:id])
      @cars = NosignCar.where(nosign_id: cookies[:nosign_id])
    else
      @car = Car.find(params[:id])
      @cars = Car.where(user_id: current_user.id)
    end
    
    if @car.in? @cars
      @car.update(quantity: params[:quantity])
      render nothing: true
    else
      result = Hash.new
      result[:id] = "forbidden"
      result[:message] = "Please modify your car!"
      render json: result, status: 403
    end

  end

  def destroy
    if current_user.nil?
      @car = NosignCar.find(params[:id])
      @cars = NosignCar.where(nosign_id: cookies[:nosign_id])
    else
      @car = Car.find(params[:id])
      @cars = Car.where(user_id: current_user.id)
    end
    
    if @car.in? @cars
      @car.destroy
      render nothing: true
    else
      result = Hash.new
      result[:id] = "forbidden"
      result[:message] = "Please delete your car!"
      render json: result, status: 403
    end

  end

  def showcar
    if current_user.nil?
      @items = NosignCar.where('nosign_id',cookies[:nosign_id])
    else
      @items = Car.where('user_id',current_user.id)
    end

  end

  private

end
