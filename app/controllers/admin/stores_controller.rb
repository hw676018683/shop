class Admin::StoresController < ApplicationController
  before_action :owner_exist?

  def update
    message = {}
    @store = Store.find_by(id: params[:id])
    if @store.update(store_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
    end
    render json: message
  end

  private

  def owner_exist?
    @owner = Admin::Owner.find_by(remember_token: Admin::Owner.encrypt(params[:remember_token]))
    if @owner.nil?
      message = {}
      message[:code] = 'failure'
      render json: message
    end
  end

  def store_params
    params.permit(:name, :background, :slogan)
  end
end
