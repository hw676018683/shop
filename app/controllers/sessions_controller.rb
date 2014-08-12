class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      redirect_back_or root_path
    else
      render 'new'
    end
  end

  def destroy
    cookies.delete[:remember_token]
    current_user = nil
    session.delete[:return_to]
    returen root_path
  end

  def redirect_back_or default
    redirect_to session[:return_to] || default
  end
end
