module SessionsHelper


  def user_exist?
    @user = User.find_by(remember_token: User.encrypt(params[:remember_token]))
    if @user.nil?
      message = {}
      message[:code] = 'failure'
      message[:error] = "Counldn't find the user"
      render json: message, status: 401
    end
  end


  def owner_exist?
    @owner = Admin::Owner.find_by(remember_token: Admin::Owner.encrypt(params[:remember_token]))
    if @owner.nil?
      message = {}
      message[:code] = 'failure'
      message[:error] = "Counldn't find the owner"
      render json: message, status: 401
    end
  end

  class AuthenticationFailed < StandardError
  end

end
