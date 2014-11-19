require_dependency 'shop/exception'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  include SessionsHelper

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  rescue_from ActiveRecord::RecordNotFound do |exception|
    record_not_found(exception)
  end

  rescue_from Shop::AuthenticationFailed do |exception|
    authentication_failed(exception)
  end


  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def record_not_found exception
    message = {}
    message[:code] = 'failure'
    message[:error] = exception.message
    render json: message, status: 404
  end

  def authentication_failed exception
    message = {}
    message[:code] = 'failure'
    message[:error] = exception.message
    render json: message, status: 401
  end

end
