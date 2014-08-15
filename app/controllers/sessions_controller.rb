class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      redirect_back_or root_path
    else
      flash[:error] = '用户名或密码不正确'
      render 'new'
    end
  end

  def destroy
    cookies.delete :remember_token
    current_user = nil
    session.delete :return_to
    redirect_to root_path
  end

  def redirect_back_or default
    logger.info "#{session[:return_to]}"
    if session[:return_to] == '/collecting_relationships'
      redirect_to root_path
      return
    end
    redirect_to session[:return_to] || default
  end
end
