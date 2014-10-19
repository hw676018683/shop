class Admin::StoresController < ApplicationController
  before_action :owner_exist?

  def update
    message = {}
    @store = Store.find_by(id: params[:id])
    if @store == @owner.store
      @store.update(name: params[:name], background: params[:background], slogan: params[:slogan])
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:errors] = 'No permission to update'
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
end
