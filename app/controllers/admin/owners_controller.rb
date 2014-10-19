class Admin::OwnersController < ApplicationController

  def signin
    message = {}
    owner = Admin::Owner.find_by(email: params[:email].downcase)
    p owner
    if owner && owner.authenticate(params[:password])
      remember_token = Admin::Owner.new_remember_token
      owner.update_attribute('remember_token', Admin::Owner.encrypt(remember_token))
      message[:code] = 'success'
      message[:owner_id] = owner.id
      message[:remember_token] = remember_token
    else
      message[:code] = 'failure' 
    end
    render json: message
  end

end
