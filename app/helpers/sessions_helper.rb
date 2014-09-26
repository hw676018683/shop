# module SessionsHelper

#   def sign_in(user)
#     remember_token = User.new_remember_token
#     cookies.permanent[:remember_token] = remember_token
#     user.update_attribute('remember_token', User.encrypt(remember_token))
#     self.current_user = user
#   end

#   def current_user
#     remember_token = User.encrypt(cookies[:remember_token])
#     @current_user ||= User.find_by(remember_token: remember_token)
#   end

#   def current_user=(user)
#     @current_user = user
#   end

#   def signed_in_user
#     if current_user.nil?
#       store_path
#       redirect_to signin_path
#     end
#   end

#   def nobaby_sign
#     if cookies[:nosign_id].nil?
#       nosign_id = SecureRandom.hex(10)
#       cookies.permanent[:nosign_id] = nosign_id
#     end
#   end

#   def store_path
#     session[:return_to] = request.fullpath
#   end
# end
