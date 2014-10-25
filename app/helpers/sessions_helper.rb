module SessionsHelper


  def user_exist?
    @user = User.find_by(remember_token: User.encrypt(params[:remember_token]), id: params[:id])
    p @user
    if @user.nil?
      message = {}
      message[:code] = 'failure'
      render json: message
    end
  end


  def owner_exist?
    @owner = Admin::Owner.find_by(remember_token: Admin::Owner.encrypt(params[:remember_token]))
    if @owner.nil?
      message = {}
      message[:code] = 'failure'
      render json: message
    end
  end


end
