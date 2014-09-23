class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      addcar_to_user
      redirect_back_or root_path
    else
      # flash[:error] = '用户名或密码不正确'
      render 'new'
      # render js: "alert('用户名或密码不正确');"
    end
  end

  def destroy
    cookies.delete :remember_token
    current_user = nil
    session.delete :return_to
    redirect_to root_path
  end

  def redirect_back_or default
    redirect_to session[:return_to] || default
  end

  def addcar_to_user
    items = []
    items << NosignCar.where(nosign_id: cookies[:nosign_id])
    logger.info("#{items[0].inspect}")
    if !items[0].nil?  
      items[0].each do |item|
        current_user.cars.create(skucate_id: item.skucate_id,quantity: item.quantity)
        item.destroy
      end
    end
  end
end
